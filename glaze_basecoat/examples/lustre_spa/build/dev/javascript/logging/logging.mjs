import { CustomType as $CustomType } from "./gleam.mjs";

export class Emergency extends $CustomType {}
export const LogLevel$Emergency = () => new Emergency();
export const LogLevel$isEmergency = (value) => value instanceof Emergency;

export class Alert extends $CustomType {}
export const LogLevel$Alert = () => new Alert();
export const LogLevel$isAlert = (value) => value instanceof Alert;

export class Critical extends $CustomType {}
export const LogLevel$Critical = () => new Critical();
export const LogLevel$isCritical = (value) => value instanceof Critical;

export class Error extends $CustomType {}
export const LogLevel$Error = () => new Error();
export const LogLevel$isError = (value) => value instanceof Error;

export class Warning extends $CustomType {}
export const LogLevel$Warning = () => new Warning();
export const LogLevel$isWarning = (value) => value instanceof Warning;

export class Notice extends $CustomType {}
export const LogLevel$Notice = () => new Notice();
export const LogLevel$isNotice = (value) => value instanceof Notice;

export class Info extends $CustomType {}
export const LogLevel$Info = () => new Info();
export const LogLevel$isInfo = (value) => value instanceof Info;

export class Debug extends $CustomType {}
export const LogLevel$Debug = () => new Debug();
export const LogLevel$isDebug = (value) => value instanceof Debug;

class Level extends $CustomType {}
