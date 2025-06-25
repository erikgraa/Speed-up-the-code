Measure-Command {
if (-not ([System.Management.Automation.PSTypeName]'FileGenerator').Type) {
  Add-Type -TypeDefinition @"
using System;
using System.Text;
using System.IO;
using System.Globalization;
using System.Collections.Generic;

public class FileGenerator {
    public static void Generate(string filePath) {
        var plcNames = new string[] { "PLC_A", "PLC_B", "PLC_C", "PLC_D" };
        var errorTypes = new string[] {
            "Sandextrator overload",
            "Conveyor misalignment",
            "Valve stuck",
            "Temperature warning"
        };
        var statusCodes = new string[] { "OK", "WARN", "ERR" };

        var random = new Random();
        var sb = new StringBuilder();
        var now = DateTime.Now;

        for (int i = 0; i < 50000; i++) {
            string timestamp = now.AddSeconds(-i).ToString("yyyy-MM-dd HH:mm:ss", CultureInfo.InvariantCulture);
            string plc = plcNames[random.Next(plcNames.Length)];
            int operatorId = random.Next(101, 121);
            int batch = random.Next(1000, 1101);
            string status = statusCodes[random.Next(statusCodes.Length)];
            double machineTemp = Math.Round((double)(random.Next(60, 110) + random.Next()), 2);
            int load = random.Next(0, 101);

            if (random.Next(1, 8) == 4) {
                string errorType = errorTypes[random.Next(errorTypes.Length)];
                if (errorType.StartsWith("S")) {
                    int value = random.Next(1, 11);
                    sb.AppendLine($"ERROR; {timestamp}; {plc}; {errorType}; {value}; {status}; {operatorId}; {batch}; {machineTemp}; {load}");
                }
                else {
                    sb.AppendLine($"ERROR; {timestamp}; {plc}; {errorType}; ; {status}; {operatorId}; {batch}; {machineTemp}; {load}");
                }
            }
            else {
                sb.AppendLine($"INFO; {timestamp}; {plc}; System running normally; ; {status}; {operatorId}; {batch}; {machineTemp}; {load}");
            }
        }

        File.WriteAllText(filePath, sb.ToString());
    }
}
"@ -Language CSharp
}

  $bigFileName = 'plc_log.txt'
  [FileGenerator]::Generate($bigFileName)

  'PLC log file generated.'
}
