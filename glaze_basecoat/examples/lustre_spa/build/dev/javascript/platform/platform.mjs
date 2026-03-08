import { CustomType as $CustomType } from "./gleam.mjs";
import { runtime as runtime_, os as os_, arch as arch_ } from "./platform_ffi.mjs";

export class Erlang extends $CustomType {}
export const Runtime$Erlang = () => new Erlang();
export const Runtime$isErlang = (value) => value instanceof Erlang;

export class Node extends $CustomType {}
export const Runtime$Node = () => new Node();
export const Runtime$isNode = (value) => value instanceof Node;

export class Bun extends $CustomType {}
export const Runtime$Bun = () => new Bun();
export const Runtime$isBun = (value) => value instanceof Bun;

export class Deno extends $CustomType {}
export const Runtime$Deno = () => new Deno();
export const Runtime$isDeno = (value) => value instanceof Deno;

export class Browser extends $CustomType {}
export const Runtime$Browser = () => new Browser();
export const Runtime$isBrowser = (value) => value instanceof Browser;

export class OtherRuntime extends $CustomType {
  constructor($0) {
    super();
    this[0] = $0;
  }
}
export const Runtime$OtherRuntime = ($0) => new OtherRuntime($0);
export const Runtime$isOtherRuntime = (value) => value instanceof OtherRuntime;
export const Runtime$OtherRuntime$0 = (value) => value[0];

export class Aix extends $CustomType {}
export const Os$Aix = () => new Aix();
export const Os$isAix = (value) => value instanceof Aix;

export class Darwin extends $CustomType {}
export const Os$Darwin = () => new Darwin();
export const Os$isDarwin = (value) => value instanceof Darwin;

export class FreeBsd extends $CustomType {}
export const Os$FreeBsd = () => new FreeBsd();
export const Os$isFreeBsd = (value) => value instanceof FreeBsd;

export class Linux extends $CustomType {}
export const Os$Linux = () => new Linux();
export const Os$isLinux = (value) => value instanceof Linux;

export class OpenBsd extends $CustomType {}
export const Os$OpenBsd = () => new OpenBsd();
export const Os$isOpenBsd = (value) => value instanceof OpenBsd;

export class SunOs extends $CustomType {}
export const Os$SunOs = () => new SunOs();
export const Os$isSunOs = (value) => value instanceof SunOs;

export class Win32 extends $CustomType {}
export const Os$Win32 = () => new Win32();
export const Os$isWin32 = (value) => value instanceof Win32;

export class OtherOs extends $CustomType {
  constructor($0) {
    super();
    this[0] = $0;
  }
}
export const Os$OtherOs = ($0) => new OtherOs($0);
export const Os$isOtherOs = (value) => value instanceof OtherOs;
export const Os$OtherOs$0 = (value) => value[0];

export class Arm extends $CustomType {}
export const Arch$Arm = () => new Arm();
export const Arch$isArm = (value) => value instanceof Arm;

export class Arm64 extends $CustomType {}
export const Arch$Arm64 = () => new Arm64();
export const Arch$isArm64 = (value) => value instanceof Arm64;

export class X86 extends $CustomType {}
export const Arch$X86 = () => new X86();
export const Arch$isX86 = (value) => value instanceof X86;

export class X64 extends $CustomType {}
export const Arch$X64 = () => new X64();
export const Arch$isX64 = (value) => value instanceof X64;

export class Loong64 extends $CustomType {}
export const Arch$Loong64 = () => new Loong64();
export const Arch$isLoong64 = (value) => value instanceof Loong64;

export class Mips extends $CustomType {}
export const Arch$Mips = () => new Mips();
export const Arch$isMips = (value) => value instanceof Mips;

export class MipsLittleEndian extends $CustomType {}
export const Arch$MipsLittleEndian = () => new MipsLittleEndian();
export const Arch$isMipsLittleEndian = (value) =>
  value instanceof MipsLittleEndian;

export class PPC extends $CustomType {}
export const Arch$PPC = () => new PPC();
export const Arch$isPPC = (value) => value instanceof PPC;

export class PPC64 extends $CustomType {}
export const Arch$PPC64 = () => new PPC64();
export const Arch$isPPC64 = (value) => value instanceof PPC64;

export class RiscV64 extends $CustomType {}
export const Arch$RiscV64 = () => new RiscV64();
export const Arch$isRiscV64 = (value) => value instanceof RiscV64;

export class S390 extends $CustomType {}
export const Arch$S390 = () => new S390();
export const Arch$isS390 = (value) => value instanceof S390;

export class S390X extends $CustomType {}
export const Arch$S390X = () => new S390X();
export const Arch$isS390X = (value) => value instanceof S390X;

export class OtherArch extends $CustomType {
  constructor($0) {
    super();
    this[0] = $0;
  }
}
export const Arch$OtherArch = ($0) => new OtherArch($0);
export const Arch$isOtherArch = (value) => value instanceof OtherArch;
export const Arch$OtherArch$0 = (value) => value[0];

/**
 * Returns the runtime this application is running on
 * 
 * On the erlang target, it'll always return `Erlang`
 * 
 * On the js target, it'll try to detect the js runtime
 */
export function runtime() {
  let $ = runtime_();
  if ($ === "erlang") {
    return new Erlang();
  } else if ($ === "node") {
    return new Node();
  } else if ($ === "bun") {
    return new Bun();
  } else if ($ === "deno") {
    return new Deno();
  } else if ($ === "browser") {
    return new Browser();
  } else {
    let runtime$1 = $;
    return new OtherRuntime(runtime$1);
  }
}

/**
 * Returns the host operating system this appication is running on
 * 
 * In web browsers, this will always return OtherOs("unknown")
 */
export function os() {
  let $ = os_();
  if ($ === "aix") {
    return new Aix();
  } else if ($ === "darwin") {
    return new Darwin();
  } else if ($ === "freebsd") {
    return new FreeBsd();
  } else if ($ === "linux") {
    return new Linux();
  } else if ($ === "openbsd") {
    return new OpenBsd();
  } else if ($ === "sunos") {
    return new SunOs();
  } else if ($ === "win32") {
    return new Win32();
  } else if ($.startsWith("win")) {
    return new Win32();
  } else {
    let os$1 = $;
    return new OtherOs(os$1);
  }
}

/**
 * Returns the CPU architecture of the host system
 * 
 * In web browsers, this will always return OtherArch("unknown")
 * 
 * On erlang for windows, it'll always return either X86 or X64, even under a beam vm compiled for arm.
 * This is because there is no simple way to get the cpu archictecture on windows, and it currently uses 
 * the bitness of the cpu to guess it instead. 
 * 
 * As of 22nd August 2024, there are no prebuilt binaries for windows for arm, so this shouldn't matter
 */
export function arch() {
  let $ = arch_();
  if ($ === "arm") {
    return new Arm();
  } else if ($ === "arm64") {
    return new Arm64();
  } else if ($ === "aarch64") {
    return new Arm64();
  } else if ($ === "x86") {
    return new X86();
  } else if ($ === "ia32") {
    return new X86();
  } else if ($ === "x64") {
    return new X64();
  } else if ($ === "x86_64") {
    return new X64();
  } else if ($ === "amd64") {
    return new X64();
  } else if ($ === "loong64") {
    return new Loong64();
  } else if ($ === "mips") {
    return new Mips();
  } else if ($ === "mipsel") {
    return new MipsLittleEndian();
  } else if ($ === "ppc") {
    return new PPC();
  } else if ($ === "ppc64") {
    return new PPC64();
  } else if ($ === "riscv64") {
    return new RiscV64();
  } else if ($ === "s390") {
    return new S390();
  } else if ($ === "s390x") {
    return new S390X();
  } else {
    let arch$1 = $;
    return new OtherArch(arch$1);
  }
}
