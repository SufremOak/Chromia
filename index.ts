import { Command } from 'commander';

const programVersion = '0.0.1';
const program = new Command();

program.name('Chromia')
program.version(programVersion)
program
  .command('repl')
  .action(function() {
    // program runtime start
  })