const { exec } = require("child_process");
keypath = process.argv[2];

if (!keypath) {
  console.error("Error: Did not receive ssh key path argument; exiting...");
  process.exit(1);
}

exec(`ssh-keygen -lE md5 -f ${keypath}`, (err, stdout) => {
  if (err) {
    console.error(`Error during 'ssh-keygen': ${err}`);
    process.exit(1);
  }

  const leftChomped = stdout.substr(stdout.indexOf(" ") + 5);
  const fingerprint = leftChomped.substr(0, leftChomped.indexOf(" "));
  console.log(JSON.stringify({ data: fingerprint }));
  process.exit(0);
});
