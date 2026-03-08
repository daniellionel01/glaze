import * as $bytes_tree from "../../../gleam_stdlib/gleam/bytes_tree.mjs";
import * as $result from "../../../gleam_stdlib/gleam/result.mjs";
import * as $glisten from "../../../glisten/glisten.mjs";
import * as $transport from "../../../glisten/glisten/transport.mjs";
import { Ssl, Tcp } from "../../../glisten/glisten/transport.mjs";
import { CustomType as $CustomType } from "../../gleam.mjs";

export class IsDir extends $CustomType {}
export const FileError$IsDir = () => new IsDir();
export const FileError$isIsDir = (value) => value instanceof IsDir;

export class NoAccess extends $CustomType {}
export const FileError$NoAccess = () => new NoAccess();
export const FileError$isNoAccess = (value) => value instanceof NoAccess;

export class NoEntry extends $CustomType {}
export const FileError$NoEntry = () => new NoEntry();
export const FileError$isNoEntry = (value) => value instanceof NoEntry;

export class UnknownFileError extends $CustomType {}
export const FileError$UnknownFileError = () => new UnknownFileError();
export const FileError$isUnknownFileError = (value) =>
  value instanceof UnknownFileError;

export class FileErr extends $CustomType {
  constructor($0) {
    super();
    this[0] = $0;
  }
}
export const SendError$FileErr = ($0) => new FileErr($0);
export const SendError$isFileErr = (value) => value instanceof FileErr;
export const SendError$FileErr$0 = (value) => value[0];

export class SocketErr extends $CustomType {
  constructor($0) {
    super();
    this[0] = $0;
  }
}
export const SendError$SocketErr = ($0) => new SocketErr($0);
export const SendError$isSocketErr = (value) => value instanceof SocketErr;
export const SendError$SocketErr$0 = (value) => value[0];

export class File extends $CustomType {
  constructor(descriptor, file_size) {
    super();
    this.descriptor = descriptor;
    this.file_size = file_size;
  }
}
export const File$File = (descriptor, file_size) =>
  new File(descriptor, file_size);
export const File$isFile = (value) => value instanceof File;
export const File$File$descriptor = (value) => value.descriptor;
export const File$File$0 = (value) => value.descriptor;
export const File$File$file_size = (value) => value.file_size;
export const File$File$1 = (value) => value.file_size;
