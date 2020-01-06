"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const vscode_1 = require("vscode");
const { createLogger, exceptions, format, transports } = require('winston');
const transportClass = require('winston-transport');
const { LEVEL, MESSAGE } = require('triple-beam');
const { combine, timestamp, printf } = format;
const transport = transportClass;
const levels = {
    error: 0,
    warn: 1,
    info: 2,
    debug: 3,
};
class OutputWindowTransport extends transport {
    constructor(opts, channel) {
        super(opts);
        this.channel = channel;
    }
    log(info, callback) {
        setImmediate(() => {
            this.emit('logged', info);
        });
        this.channel.appendLine(info[MESSAGE]);
        callback();
    }
}
class ConsoleLogTransport extends transport {
    constructor(opts) {
        super(opts);
    }
    log(info, callback) {
        setImmediate(() => {
            this.emit('logged', info);
        });
        const level = info[LEVEL];
        switch (level) {
            case 'error':
                console.error(info[MESSAGE]);
                break;
            case 'warn':
                console.warn(info[MESSAGE]);
                break;
            default:
                console.log(info[MESSAGE]);
                break;
        }
        callback();
    }
}
const loggerTransports = [
    new ConsoleLogTransport({
        level: !!process.env.CI || !!process.env.LOCAL_TEST ? 'error' : 'debug',
    }),
];
function winstonLogger(verbosity, context) {
    const level = !!process.env.CI ? 'error' : verbosity;
    if (!process.env.CI && !process.env.EXT_DEBUG && !process.env.LOCAL_TEST) {
        const channel = vscode_1.window.createOutputChannel('TypeScript Hero');
        context.subscriptions.push(channel);
        const fileHandler = new transports.File({
            level: ['info', 'debug'].indexOf(level) >= 0 ? level : 'info',
            exitOnError: false,
            filename: 'typescript-hero.log',
            dirname: context.extensionPath,
            maxsize: 1024 * 1024,
            maxFiles: 1,
            tailable: true,
        });
        const outputHandler = new OutputWindowTransport({ exitOnError: false }, channel);
        loggerTransports.push(fileHandler);
        loggerTransports.push(outputHandler);
        exceptions.handle(fileHandler);
    }
    const logger = createLogger({
        level,
        levels,
        format: combine(format.splat(), timestamp(), printf((info) => {
            const message = `${info.timestamp} - ${info.level}: ${info.message}`;
            const data = Object.assign({}, info, { level: undefined, message: undefined, splat: undefined, timestamp: undefined });
            if (Object.keys(data).filter(key => !!data[key]).length > 0) {
                return `${message} ${JSON.stringify(data)}`;
            }
            return message;
        })),
        transports: loggerTransports,
    });
    logger.exitOnError = false;
    return logger;
}
exports.winstonLogger = winstonLogger;
