import * as $httpc from "../../gleam_httpc/gleam/httpc.mjs";
import * as $actor from "../../gleam_otp/gleam/otp/actor.mjs";
import * as $string from "../../gleam_stdlib/gleam/string.mjs";
import * as $simplifile from "../../simplifile/simplifile.mjs";
import { CustomType as $CustomType } from "../gleam.mjs";
import * as $system from "../lustre_dev_tools/system.mjs";

export class CouldNotDownloadBunBinary extends $CustomType {
  constructor(reason) {
    super();
    this.reason = reason;
  }
}
export const Error$CouldNotDownloadBunBinary = (reason) =>
  new CouldNotDownloadBunBinary(reason);
export const Error$isCouldNotDownloadBunBinary = (value) =>
  value instanceof CouldNotDownloadBunBinary;
export const Error$CouldNotDownloadBunBinary$reason = (value) => value.reason;
export const Error$CouldNotDownloadBunBinary$0 = (value) => value.reason;

export class CouldNotDownloadTailwindBinary extends $CustomType {
  constructor(reason) {
    super();
    this.reason = reason;
  }
}
export const Error$CouldNotDownloadTailwindBinary = (reason) =>
  new CouldNotDownloadTailwindBinary(reason);
export const Error$isCouldNotDownloadTailwindBinary = (value) =>
  value instanceof CouldNotDownloadTailwindBinary;
export const Error$CouldNotDownloadTailwindBinary$reason = (value) =>
  value.reason;
export const Error$CouldNotDownloadTailwindBinary$0 = (value) => value.reason;

export class CouldNotExtractBunArchive extends $CustomType {
  constructor(os, arch, version) {
    super();
    this.os = os;
    this.arch = arch;
    this.version = version;
  }
}
export const Error$CouldNotExtractBunArchive = (os, arch, version) =>
  new CouldNotExtractBunArchive(os, arch, version);
export const Error$isCouldNotExtractBunArchive = (value) =>
  value instanceof CouldNotExtractBunArchive;
export const Error$CouldNotExtractBunArchive$os = (value) => value.os;
export const Error$CouldNotExtractBunArchive$0 = (value) => value.os;
export const Error$CouldNotExtractBunArchive$arch = (value) => value.arch;
export const Error$CouldNotExtractBunArchive$1 = (value) => value.arch;
export const Error$CouldNotExtractBunArchive$version = (value) => value.version;
export const Error$CouldNotExtractBunArchive$2 = (value) => value.version;

export class CouldNotInitialiseDevTools extends $CustomType {
  constructor(reason) {
    super();
    this.reason = reason;
  }
}
export const Error$CouldNotInitialiseDevTools = (reason) =>
  new CouldNotInitialiseDevTools(reason);
export const Error$isCouldNotInitialiseDevTools = (value) =>
  value instanceof CouldNotInitialiseDevTools;
export const Error$CouldNotInitialiseDevTools$reason = (value) => value.reason;
export const Error$CouldNotInitialiseDevTools$0 = (value) => value.reason;

export class CouldNotLocateBunBinary extends $CustomType {
  constructor(path) {
    super();
    this.path = path;
  }
}
export const Error$CouldNotLocateBunBinary = (path) =>
  new CouldNotLocateBunBinary(path);
export const Error$isCouldNotLocateBunBinary = (value) =>
  value instanceof CouldNotLocateBunBinary;
export const Error$CouldNotLocateBunBinary$path = (value) => value.path;
export const Error$CouldNotLocateBunBinary$0 = (value) => value.path;

export class CouldNotLocateTailwindBinary extends $CustomType {
  constructor(path) {
    super();
    this.path = path;
  }
}
export const Error$CouldNotLocateTailwindBinary = (path) =>
  new CouldNotLocateTailwindBinary(path);
export const Error$isCouldNotLocateTailwindBinary = (value) =>
  value instanceof CouldNotLocateTailwindBinary;
export const Error$CouldNotLocateTailwindBinary$path = (value) => value.path;
export const Error$CouldNotLocateTailwindBinary$0 = (value) => value.path;

export class CouldNotLocateGleamBinary extends $CustomType {}
export const Error$CouldNotLocateGleamBinary = () =>
  new CouldNotLocateGleamBinary();
export const Error$isCouldNotLocateGleamBinary = (value) =>
  value instanceof CouldNotLocateGleamBinary;

export class CouldNotReadFile extends $CustomType {
  constructor(path, reason) {
    super();
    this.path = path;
    this.reason = reason;
  }
}
export const Error$CouldNotReadFile = (path, reason) =>
  new CouldNotReadFile(path, reason);
export const Error$isCouldNotReadFile = (value) =>
  value instanceof CouldNotReadFile;
export const Error$CouldNotReadFile$path = (value) => value.path;
export const Error$CouldNotReadFile$0 = (value) => value.path;
export const Error$CouldNotReadFile$reason = (value) => value.reason;
export const Error$CouldNotReadFile$1 = (value) => value.reason;

export class CouldNotSetFilePermissions extends $CustomType {
  constructor(path, reason) {
    super();
    this.path = path;
    this.reason = reason;
  }
}
export const Error$CouldNotSetFilePermissions = (path, reason) =>
  new CouldNotSetFilePermissions(path, reason);
export const Error$isCouldNotSetFilePermissions = (value) =>
  value instanceof CouldNotSetFilePermissions;
export const Error$CouldNotSetFilePermissions$path = (value) => value.path;
export const Error$CouldNotSetFilePermissions$0 = (value) => value.path;
export const Error$CouldNotSetFilePermissions$reason = (value) => value.reason;
export const Error$CouldNotSetFilePermissions$1 = (value) => value.reason;

export class CouldNotStartDevServer extends $CustomType {
  constructor(reason) {
    super();
    this.reason = reason;
  }
}
export const Error$CouldNotStartDevServer = (reason) =>
  new CouldNotStartDevServer(reason);
export const Error$isCouldNotStartDevServer = (value) =>
  value instanceof CouldNotStartDevServer;
export const Error$CouldNotStartDevServer$reason = (value) => value.reason;
export const Error$CouldNotStartDevServer$0 = (value) => value.reason;

export class CouldNotStartFileWatcher extends $CustomType {
  constructor(watcher, os, arch) {
    super();
    this.watcher = watcher;
    this.os = os;
    this.arch = arch;
  }
}
export const Error$CouldNotStartFileWatcher = (watcher, os, arch) =>
  new CouldNotStartFileWatcher(watcher, os, arch);
export const Error$isCouldNotStartFileWatcher = (value) =>
  value instanceof CouldNotStartFileWatcher;
export const Error$CouldNotStartFileWatcher$watcher = (value) => value.watcher;
export const Error$CouldNotStartFileWatcher$0 = (value) => value.watcher;
export const Error$CouldNotStartFileWatcher$os = (value) => value.os;
export const Error$CouldNotStartFileWatcher$1 = (value) => value.os;
export const Error$CouldNotStartFileWatcher$arch = (value) => value.arch;
export const Error$CouldNotStartFileWatcher$2 = (value) => value.arch;

export class CouldNotVerifyBunHash extends $CustomType {
  constructor(expected, actual) {
    super();
    this.expected = expected;
    this.actual = actual;
  }
}
export const Error$CouldNotVerifyBunHash = (expected, actual) =>
  new CouldNotVerifyBunHash(expected, actual);
export const Error$isCouldNotVerifyBunHash = (value) =>
  value instanceof CouldNotVerifyBunHash;
export const Error$CouldNotVerifyBunHash$expected = (value) => value.expected;
export const Error$CouldNotVerifyBunHash$0 = (value) => value.expected;
export const Error$CouldNotVerifyBunHash$actual = (value) => value.actual;
export const Error$CouldNotVerifyBunHash$1 = (value) => value.actual;

export class CouldNotVerifyTailwindHash extends $CustomType {
  constructor(expected, actual) {
    super();
    this.expected = expected;
    this.actual = actual;
  }
}
export const Error$CouldNotVerifyTailwindHash = (expected, actual) =>
  new CouldNotVerifyTailwindHash(expected, actual);
export const Error$isCouldNotVerifyTailwindHash = (value) =>
  value instanceof CouldNotVerifyTailwindHash;
export const Error$CouldNotVerifyTailwindHash$expected = (value) =>
  value.expected;
export const Error$CouldNotVerifyTailwindHash$0 = (value) => value.expected;
export const Error$CouldNotVerifyTailwindHash$actual = (value) => value.actual;
export const Error$CouldNotVerifyTailwindHash$1 = (value) => value.actual;

export class CouldNotWriteFile extends $CustomType {
  constructor(path, reason) {
    super();
    this.path = path;
    this.reason = reason;
  }
}
export const Error$CouldNotWriteFile = (path, reason) =>
  new CouldNotWriteFile(path, reason);
export const Error$isCouldNotWriteFile = (value) =>
  value instanceof CouldNotWriteFile;
export const Error$CouldNotWriteFile$path = (value) => value.path;
export const Error$CouldNotWriteFile$0 = (value) => value.path;
export const Error$CouldNotWriteFile$reason = (value) => value.reason;
export const Error$CouldNotWriteFile$1 = (value) => value.reason;

export class ExternalCommandFailed extends $CustomType {
  constructor(command, reason) {
    super();
    this.command = command;
    this.reason = reason;
  }
}
export const Error$ExternalCommandFailed = (command, reason) =>
  new ExternalCommandFailed(command, reason);
export const Error$isExternalCommandFailed = (value) =>
  value instanceof ExternalCommandFailed;
export const Error$ExternalCommandFailed$command = (value) => value.command;
export const Error$ExternalCommandFailed$0 = (value) => value.command;
export const Error$ExternalCommandFailed$reason = (value) => value.reason;
export const Error$ExternalCommandFailed$1 = (value) => value.reason;

export class FailedToBuildProject extends $CustomType {
  constructor(reason) {
    super();
    this.reason = reason;
  }
}
export const Error$FailedToBuildProject = (reason) =>
  new FailedToBuildProject(reason);
export const Error$isFailedToBuildProject = (value) =>
  value instanceof FailedToBuildProject;
export const Error$FailedToBuildProject$reason = (value) => value.reason;
export const Error$FailedToBuildProject$0 = (value) => value.reason;

export class MissingRequiredFlag extends $CustomType {
  constructor(name) {
    super();
    this.name = name;
  }
}
export const Error$MissingRequiredFlag = (name) =>
  new MissingRequiredFlag(name);
export const Error$isMissingRequiredFlag = (value) =>
  value instanceof MissingRequiredFlag;
export const Error$MissingRequiredFlag$name = (value) => value.name;
export const Error$MissingRequiredFlag$0 = (value) => value.name;

export class MustBeProjectRoot extends $CustomType {
  constructor(path) {
    super();
    this.path = path;
  }
}
export const Error$MustBeProjectRoot = (path) => new MustBeProjectRoot(path);
export const Error$isMustBeProjectRoot = (value) =>
  value instanceof MustBeProjectRoot;
export const Error$MustBeProjectRoot$path = (value) => value.path;
export const Error$MustBeProjectRoot$0 = (value) => value.path;

export class ProxyInvalidTo extends $CustomType {}
export const Error$ProxyInvalidTo = () => new ProxyInvalidTo();
export const Error$isProxyInvalidTo = (value) =>
  value instanceof ProxyInvalidTo;

export class ProxyMissingFrom extends $CustomType {}
export const Error$ProxyMissingFrom = () => new ProxyMissingFrom();
export const Error$isProxyMissingFrom = (value) =>
  value instanceof ProxyMissingFrom;

export class ProxyMissingTo extends $CustomType {}
export const Error$ProxyMissingTo = () => new ProxyMissingTo();
export const Error$isProxyMissingTo = (value) =>
  value instanceof ProxyMissingTo;

export class UnknownBuildTool extends $CustomType {
  constructor(name) {
    super();
    this.name = name;
  }
}
export const Error$UnknownBuildTool = (name) => new UnknownBuildTool(name);
export const Error$isUnknownBuildTool = (value) =>
  value instanceof UnknownBuildTool;
export const Error$UnknownBuildTool$name = (value) => value.name;
export const Error$UnknownBuildTool$0 = (value) => value.name;

export class UnknownGleamModule extends $CustomType {
  constructor(name) {
    super();
    this.name = name;
  }
}
export const Error$UnknownGleamModule = (name) => new UnknownGleamModule(name);
export const Error$isUnknownGleamModule = (value) =>
  value instanceof UnknownGleamModule;
export const Error$UnknownGleamModule$name = (value) => value.name;
export const Error$UnknownGleamModule$0 = (value) => value.name;

export class UnknownIntegration extends $CustomType {
  constructor(name) {
    super();
    this.name = name;
  }
}
export const Error$UnknownIntegration = (name) => new UnknownIntegration(name);
export const Error$isUnknownIntegration = (value) =>
  value instanceof UnknownIntegration;
export const Error$UnknownIntegration$name = (value) => value.name;
export const Error$UnknownIntegration$0 = (value) => value.name;

export class UnknownWatchStrategy extends $CustomType {
  constructor(name) {
    super();
    this.name = name;
  }
}
export const Error$UnknownWatchStrategy = (name) =>
  new UnknownWatchStrategy(name);
export const Error$isUnknownWatchStrategy = (value) =>
  value instanceof UnknownWatchStrategy;
export const Error$UnknownWatchStrategy$name = (value) => value.name;
export const Error$UnknownWatchStrategy$0 = (value) => value.name;

export class UnsupportedBunVersion extends $CustomType {
  constructor(path, expected, actual) {
    super();
    this.path = path;
    this.expected = expected;
    this.actual = actual;
  }
}
export const Error$UnsupportedBunVersion = (path, expected, actual) =>
  new UnsupportedBunVersion(path, expected, actual);
export const Error$isUnsupportedBunVersion = (value) =>
  value instanceof UnsupportedBunVersion;
export const Error$UnsupportedBunVersion$path = (value) => value.path;
export const Error$UnsupportedBunVersion$0 = (value) => value.path;
export const Error$UnsupportedBunVersion$expected = (value) => value.expected;
export const Error$UnsupportedBunVersion$1 = (value) => value.expected;
export const Error$UnsupportedBunVersion$actual = (value) => value.actual;
export const Error$UnsupportedBunVersion$2 = (value) => value.actual;

export class UnsupportedPlatform extends $CustomType {
  constructor(os, arch) {
    super();
    this.os = os;
    this.arch = arch;
  }
}
export const Error$UnsupportedPlatform = (os, arch) =>
  new UnsupportedPlatform(os, arch);
export const Error$isUnsupportedPlatform = (value) =>
  value instanceof UnsupportedPlatform;
export const Error$UnsupportedPlatform$os = (value) => value.os;
export const Error$UnsupportedPlatform$0 = (value) => value.os;
export const Error$UnsupportedPlatform$arch = (value) => value.arch;
export const Error$UnsupportedPlatform$1 = (value) => value.arch;

export class UnsupportedTailwindVersion extends $CustomType {
  constructor(path, expected, actual) {
    super();
    this.path = path;
    this.expected = expected;
    this.actual = actual;
  }
}
export const Error$UnsupportedTailwindVersion = (path, expected, actual) =>
  new UnsupportedTailwindVersion(path, expected, actual);
export const Error$isUnsupportedTailwindVersion = (value) =>
  value instanceof UnsupportedTailwindVersion;
export const Error$UnsupportedTailwindVersion$path = (value) => value.path;
export const Error$UnsupportedTailwindVersion$0 = (value) => value.path;
export const Error$UnsupportedTailwindVersion$expected = (value) =>
  value.expected;
export const Error$UnsupportedTailwindVersion$1 = (value) => value.expected;
export const Error$UnsupportedTailwindVersion$actual = (value) => value.actual;
export const Error$UnsupportedTailwindVersion$2 = (value) => value.actual;
