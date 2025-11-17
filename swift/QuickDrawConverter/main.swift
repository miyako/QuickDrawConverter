//
//  main.swift
//  QuickDrawConverter
//
//  Created by Matthias Wiesmann on 12.08.2025.
//

import Foundation

func loadFileFromLocalPath(_ localFilePath: String) ->Data? {
  return try? Data(contentsOf: URL(fileURLWithPath: localFilePath))
}

func stdOutWrite(_ string: String) {
  try! FileHandle.standardOutput.write(contentsOf: Data(string.utf8))
}

func stdErrWrite(_ string: String) {
  try! FileHandle.standardError.write(contentsOf: Data(string.utf8))
}

func usage(args: [String]) -> NSError {
    return NSError(domain: "cli", code: 1,
                  userInfo: [NSLocalizedDescriptionKey:
                                "Usage: \(args[0]) <input_path> <output_path>"])
}

func main() throws {
    
    let args = CommandLine.arguments
    
    // Expect: program input_path output_path
    guard args.count > 1 else {
        throw usage(args: args);
    }
   
    let inputPath = args[1]
    if inputPath == "-" {
        let data = FileHandle.standardInput.readDataToEndOfFile();
        do {
            let parser = try QDParser(data: data);
            let picture = try parser.parse();
            let pdfData = picture.pdfData();
            try FileHandle.standardOutput.write(contentsOf: pdfData);
        } catch {
            stdErrWrite("Error \(error) while converting");
        }
    }else{
        if args.count > 2 {
            let outputPath = args[2]
            if let data = loadFileFromLocalPath(inputPath) {
                let outputURL = URL(fileURLWithPath: outputPath)
                let dirURL = outputURL.deletingLastPathComponent()
                try FileManager.default.createDirectory(
                        at: dirURL,
                        withIntermediateDirectories: true,
                        attributes: nil
                    )
                do {
                    let parser = try QDParser(data: data);
                    let picture = try parser.parse();
                    let pdfData = picture.pdfData();
                    try pdfData.write(to: URL(fileURLWithPath: outputPath), options: .atomic);
                } catch {
                    stdErrWrite("Error \(error) while converting \(inputPath)");
                }
            }
        }else{
            throw usage(args: args);
        }
    }
}

do {
    try main()
} catch {
    fputs("Error: \(error.localizedDescription)\n", stderr)
    exit(1)
}
