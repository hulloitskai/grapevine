const { exec } = require("child_process");
const path = require("path");
const fs = require("fs");
const ignitionRootPath = process.argv[2];

if (!ignitionRootPath) {
  console.error(
    "Error: Did not receive Ignition root path argument; exiting..."
  );
  process.exit(1);
}

exec("yarn make", { cwd: ignitionRootPath }, err => {
  if (err) {
    console.error(`Error during 'yarn make': ${err}`);
    process.exit(1);
  }

  const ignitionConfigPath = path.join(
    ignitionRootPath,
    "out",
    "ignition-config.json"
  );

  fs.readFile(ignitionConfigPath, (err, data) => {
    if (err) {
      console.error(`Error during Ignition file read: ${err}`);
      process.exit(2);
    }
    console.log(JSON.stringify({ data: data.toString() }));
    process.exit(0);
  });
});
