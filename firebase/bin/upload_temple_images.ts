import glob from 'glob';
import { exec } from 'child_process';
import { setTimeout } from 'timers/promises';

const rootDir = 'temples/images/';
const projectName = process.env.PROJECT_NAME ?? '';
if (projectName === '') {
  console.error('PROJECT_NAME must be set Cloud Storage project name!');
  process.exit();
}

glob(`${rootDir}*`, (err, dirs) => {
  if (err) {
    console.error(err);
    return;
  }

  for (const dir of dirs) {
    const numStr = dir.replace(rootDir, '');
    exec(
      `gsutil cp ${dir}/*.* gs://${projectName}.appspot.com/temples/${numStr}/`,
      async (err, stdout, stderr) => {
        await setTimeout(1, '');
        if (err) {
          console.error('===============');
          console.error(err);
          console.error('===============');
          return;
        }
        if (stdout.length > 0) {
          console.log(`stdout: ${stdout}`);
        }
        if (stderr.length > 0) {
          console.log(`stderr: ${stderr}`);
        }
      }
    );
  }
});
