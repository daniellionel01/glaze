import * as $directories from "../../directories/directories.mjs";
import * as $filepath from "../../filepath/filepath.mjs";
import * as $crypto from "../../gleam_crypto/gleam/crypto.mjs";
import * as $bit_array from "../../gleam_stdlib/gleam/bit_array.mjs";
import * as $int from "../../gleam_stdlib/gleam/int.mjs";
import * as $string from "../../gleam_stdlib/gleam/string.mjs";
import { Ok, CustomType as $CustomType } from "../gleam.mjs";

export class Connection extends $CustomType {
  constructor(reader, max_body_size, max_files_size, read_chunk_size, secret_key_base, temporary_directory) {
    super();
    this.reader = reader;
    this.max_body_size = max_body_size;
    this.max_files_size = max_files_size;
    this.read_chunk_size = read_chunk_size;
    this.secret_key_base = secret_key_base;
    this.temporary_directory = temporary_directory;
  }
}
export const Connection$Connection = (reader, max_body_size, max_files_size, read_chunk_size, secret_key_base, temporary_directory) =>
  new Connection(reader,
  max_body_size,
  max_files_size,
  read_chunk_size,
  secret_key_base,
  temporary_directory);
export const Connection$isConnection = (value) => value instanceof Connection;
export const Connection$Connection$reader = (value) => value.reader;
export const Connection$Connection$0 = (value) => value.reader;
export const Connection$Connection$max_body_size = (value) =>
  value.max_body_size;
export const Connection$Connection$1 = (value) => value.max_body_size;
export const Connection$Connection$max_files_size = (value) =>
  value.max_files_size;
export const Connection$Connection$2 = (value) => value.max_files_size;
export const Connection$Connection$read_chunk_size = (value) =>
  value.read_chunk_size;
export const Connection$Connection$3 = (value) => value.read_chunk_size;
export const Connection$Connection$secret_key_base = (value) =>
  value.secret_key_base;
export const Connection$Connection$4 = (value) => value.secret_key_base;
export const Connection$Connection$temporary_directory = (value) =>
  value.temporary_directory;
export const Connection$Connection$5 = (value) => value.temporary_directory;

export class Chunk extends $CustomType {
  constructor($0, next) {
    super();
    this[0] = $0;
    this.next = next;
  }
}
export const Read$Chunk = ($0, next) => new Chunk($0, next);
export const Read$isChunk = (value) => value instanceof Chunk;
export const Read$Chunk$0 = (value) => value[0];
export const Read$Chunk$next = (value) => value.next;
export const Read$Chunk$1 = (value) => value.next;

export class ReadingFinished extends $CustomType {}
export const Read$ReadingFinished = () => new ReadingFinished();
export const Read$isReadingFinished = (value) =>
  value instanceof ReadingFinished;

export function remove_preceeding_slashes(loop$string) {
  while (true) {
    let string = loop$string;
    if (string.startsWith("/")) {
      let rest = string.slice(1);
      loop$string = rest;
    } else {
      return string;
    }
  }
}

/**
 * Generate a random string of the given length.
 */
export function random_string(length) {
  let _pipe = $crypto.strong_random_bytes(length);
  let _pipe$1 = $bit_array.base64_url_encode(_pipe, false);
  return $string.slice(_pipe$1, 0, length);
}

export function random_slug() {
  return random_string(16);
}

export function make_connection(body_reader, secret_key_base) {
  let _block;
  let $ = $directories.tmp_dir();
  if ($ instanceof Ok) {
    let tmp_dir = $[0];
    _block = tmp_dir + "/gleam-wisp/";
  } else {
    _block = "./tmp/";
  }
  let prefix = _block;
  let temporary_directory = $filepath.join(prefix, random_slug());
  return new Connection(
    body_reader,
    8_000_000,
    32_000_000,
    1_000_000,
    secret_key_base,
    temporary_directory,
  );
}

/**
 * Generates etag using file size + file mtime as seconds
 *
 * Exmaple etag value: `2C-67A4D2F1`
 */
export function generate_etag(file_size, mtime_seconds) {
  return ($int.to_base16(file_size) + "-") + $int.to_base16(mtime_seconds);
}
