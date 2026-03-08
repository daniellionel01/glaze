import { CustomType as $CustomType } from "../gleam.mjs";

export class Closed extends $CustomType {}
export const SocketReason$Closed = () => new Closed();
export const SocketReason$isClosed = (value) => value instanceof Closed;

export class Timeout extends $CustomType {}
export const SocketReason$Timeout = () => new Timeout();
export const SocketReason$isTimeout = (value) => value instanceof Timeout;

export class Badarg extends $CustomType {}
export const SocketReason$Badarg = () => new Badarg();
export const SocketReason$isBadarg = (value) => value instanceof Badarg;

export class Terminated extends $CustomType {}
export const SocketReason$Terminated = () => new Terminated();
export const SocketReason$isTerminated = (value) => value instanceof Terminated;

export class Eaddrinuse extends $CustomType {}
export const SocketReason$Eaddrinuse = () => new Eaddrinuse();
export const SocketReason$isEaddrinuse = (value) => value instanceof Eaddrinuse;

export class Eaddrnotavail extends $CustomType {}
export const SocketReason$Eaddrnotavail = () => new Eaddrnotavail();
export const SocketReason$isEaddrnotavail = (value) =>
  value instanceof Eaddrnotavail;

export class Eafnosupport extends $CustomType {}
export const SocketReason$Eafnosupport = () => new Eafnosupport();
export const SocketReason$isEafnosupport = (value) =>
  value instanceof Eafnosupport;

export class Ealready extends $CustomType {}
export const SocketReason$Ealready = () => new Ealready();
export const SocketReason$isEalready = (value) => value instanceof Ealready;

export class Econnaborted extends $CustomType {}
export const SocketReason$Econnaborted = () => new Econnaborted();
export const SocketReason$isEconnaborted = (value) =>
  value instanceof Econnaborted;

export class Econnrefused extends $CustomType {}
export const SocketReason$Econnrefused = () => new Econnrefused();
export const SocketReason$isEconnrefused = (value) =>
  value instanceof Econnrefused;

export class Econnreset extends $CustomType {}
export const SocketReason$Econnreset = () => new Econnreset();
export const SocketReason$isEconnreset = (value) => value instanceof Econnreset;

export class Edestaddrreq extends $CustomType {}
export const SocketReason$Edestaddrreq = () => new Edestaddrreq();
export const SocketReason$isEdestaddrreq = (value) =>
  value instanceof Edestaddrreq;

export class Ehostdown extends $CustomType {}
export const SocketReason$Ehostdown = () => new Ehostdown();
export const SocketReason$isEhostdown = (value) => value instanceof Ehostdown;

export class Ehostunreach extends $CustomType {}
export const SocketReason$Ehostunreach = () => new Ehostunreach();
export const SocketReason$isEhostunreach = (value) =>
  value instanceof Ehostunreach;

export class Einprogress extends $CustomType {}
export const SocketReason$Einprogress = () => new Einprogress();
export const SocketReason$isEinprogress = (value) =>
  value instanceof Einprogress;

export class Eisconn extends $CustomType {}
export const SocketReason$Eisconn = () => new Eisconn();
export const SocketReason$isEisconn = (value) => value instanceof Eisconn;

export class Emsgsize extends $CustomType {}
export const SocketReason$Emsgsize = () => new Emsgsize();
export const SocketReason$isEmsgsize = (value) => value instanceof Emsgsize;

export class Enetdown extends $CustomType {}
export const SocketReason$Enetdown = () => new Enetdown();
export const SocketReason$isEnetdown = (value) => value instanceof Enetdown;

export class Enetunreach extends $CustomType {}
export const SocketReason$Enetunreach = () => new Enetunreach();
export const SocketReason$isEnetunreach = (value) =>
  value instanceof Enetunreach;

export class Enopkg extends $CustomType {}
export const SocketReason$Enopkg = () => new Enopkg();
export const SocketReason$isEnopkg = (value) => value instanceof Enopkg;

export class Enoprotoopt extends $CustomType {}
export const SocketReason$Enoprotoopt = () => new Enoprotoopt();
export const SocketReason$isEnoprotoopt = (value) =>
  value instanceof Enoprotoopt;

export class Enotconn extends $CustomType {}
export const SocketReason$Enotconn = () => new Enotconn();
export const SocketReason$isEnotconn = (value) => value instanceof Enotconn;

export class Enotty extends $CustomType {}
export const SocketReason$Enotty = () => new Enotty();
export const SocketReason$isEnotty = (value) => value instanceof Enotty;

export class Enotsock extends $CustomType {}
export const SocketReason$Enotsock = () => new Enotsock();
export const SocketReason$isEnotsock = (value) => value instanceof Enotsock;

export class Eproto extends $CustomType {}
export const SocketReason$Eproto = () => new Eproto();
export const SocketReason$isEproto = (value) => value instanceof Eproto;

export class Eprotonosupport extends $CustomType {}
export const SocketReason$Eprotonosupport = () => new Eprotonosupport();
export const SocketReason$isEprotonosupport = (value) =>
  value instanceof Eprotonosupport;

export class Eprototype extends $CustomType {}
export const SocketReason$Eprototype = () => new Eprototype();
export const SocketReason$isEprototype = (value) => value instanceof Eprototype;

export class Esocktnosupport extends $CustomType {}
export const SocketReason$Esocktnosupport = () => new Esocktnosupport();
export const SocketReason$isEsocktnosupport = (value) =>
  value instanceof Esocktnosupport;

export class Etimedout extends $CustomType {}
export const SocketReason$Etimedout = () => new Etimedout();
export const SocketReason$isEtimedout = (value) => value instanceof Etimedout;

export class Ewouldblock extends $CustomType {}
export const SocketReason$Ewouldblock = () => new Ewouldblock();
export const SocketReason$isEwouldblock = (value) =>
  value instanceof Ewouldblock;

export class Exbadport extends $CustomType {}
export const SocketReason$Exbadport = () => new Exbadport();
export const SocketReason$isExbadport = (value) => value instanceof Exbadport;

export class Exbadseq extends $CustomType {}
export const SocketReason$Exbadseq = () => new Exbadseq();
export const SocketReason$isExbadseq = (value) => value instanceof Exbadseq;

export class Eacces extends $CustomType {}
export const SocketReason$Eacces = () => new Eacces();
export const SocketReason$isEacces = (value) => value instanceof Eacces;

export class Eagain extends $CustomType {}
export const SocketReason$Eagain = () => new Eagain();
export const SocketReason$isEagain = (value) => value instanceof Eagain;

export class Ebadf extends $CustomType {}
export const SocketReason$Ebadf = () => new Ebadf();
export const SocketReason$isEbadf = (value) => value instanceof Ebadf;

export class Ebadmsg extends $CustomType {}
export const SocketReason$Ebadmsg = () => new Ebadmsg();
export const SocketReason$isEbadmsg = (value) => value instanceof Ebadmsg;

export class Ebusy extends $CustomType {}
export const SocketReason$Ebusy = () => new Ebusy();
export const SocketReason$isEbusy = (value) => value instanceof Ebusy;

export class Edeadlk extends $CustomType {}
export const SocketReason$Edeadlk = () => new Edeadlk();
export const SocketReason$isEdeadlk = (value) => value instanceof Edeadlk;

export class Edeadlock extends $CustomType {}
export const SocketReason$Edeadlock = () => new Edeadlock();
export const SocketReason$isEdeadlock = (value) => value instanceof Edeadlock;

export class Edquot extends $CustomType {}
export const SocketReason$Edquot = () => new Edquot();
export const SocketReason$isEdquot = (value) => value instanceof Edquot;

export class Eexist extends $CustomType {}
export const SocketReason$Eexist = () => new Eexist();
export const SocketReason$isEexist = (value) => value instanceof Eexist;

export class Efault extends $CustomType {}
export const SocketReason$Efault = () => new Efault();
export const SocketReason$isEfault = (value) => value instanceof Efault;

export class Efbig extends $CustomType {}
export const SocketReason$Efbig = () => new Efbig();
export const SocketReason$isEfbig = (value) => value instanceof Efbig;

export class Eftype extends $CustomType {}
export const SocketReason$Eftype = () => new Eftype();
export const SocketReason$isEftype = (value) => value instanceof Eftype;

export class Eintr extends $CustomType {}
export const SocketReason$Eintr = () => new Eintr();
export const SocketReason$isEintr = (value) => value instanceof Eintr;

export class Einval extends $CustomType {}
export const SocketReason$Einval = () => new Einval();
export const SocketReason$isEinval = (value) => value instanceof Einval;

export class Eio extends $CustomType {}
export const SocketReason$Eio = () => new Eio();
export const SocketReason$isEio = (value) => value instanceof Eio;

export class Eisdir extends $CustomType {}
export const SocketReason$Eisdir = () => new Eisdir();
export const SocketReason$isEisdir = (value) => value instanceof Eisdir;

export class Eloop extends $CustomType {}
export const SocketReason$Eloop = () => new Eloop();
export const SocketReason$isEloop = (value) => value instanceof Eloop;

export class Emfile extends $CustomType {}
export const SocketReason$Emfile = () => new Emfile();
export const SocketReason$isEmfile = (value) => value instanceof Emfile;

export class Emlink extends $CustomType {}
export const SocketReason$Emlink = () => new Emlink();
export const SocketReason$isEmlink = (value) => value instanceof Emlink;

export class Emultihop extends $CustomType {}
export const SocketReason$Emultihop = () => new Emultihop();
export const SocketReason$isEmultihop = (value) => value instanceof Emultihop;

export class Enametoolong extends $CustomType {}
export const SocketReason$Enametoolong = () => new Enametoolong();
export const SocketReason$isEnametoolong = (value) =>
  value instanceof Enametoolong;

export class Enfile extends $CustomType {}
export const SocketReason$Enfile = () => new Enfile();
export const SocketReason$isEnfile = (value) => value instanceof Enfile;

export class Enobufs extends $CustomType {}
export const SocketReason$Enobufs = () => new Enobufs();
export const SocketReason$isEnobufs = (value) => value instanceof Enobufs;

export class Enodev extends $CustomType {}
export const SocketReason$Enodev = () => new Enodev();
export const SocketReason$isEnodev = (value) => value instanceof Enodev;

export class Enolck extends $CustomType {}
export const SocketReason$Enolck = () => new Enolck();
export const SocketReason$isEnolck = (value) => value instanceof Enolck;

export class Enolink extends $CustomType {}
export const SocketReason$Enolink = () => new Enolink();
export const SocketReason$isEnolink = (value) => value instanceof Enolink;

export class Enoent extends $CustomType {}
export const SocketReason$Enoent = () => new Enoent();
export const SocketReason$isEnoent = (value) => value instanceof Enoent;

export class Enomem extends $CustomType {}
export const SocketReason$Enomem = () => new Enomem();
export const SocketReason$isEnomem = (value) => value instanceof Enomem;

export class Enospc extends $CustomType {}
export const SocketReason$Enospc = () => new Enospc();
export const SocketReason$isEnospc = (value) => value instanceof Enospc;

export class Enosr extends $CustomType {}
export const SocketReason$Enosr = () => new Enosr();
export const SocketReason$isEnosr = (value) => value instanceof Enosr;

export class Enostr extends $CustomType {}
export const SocketReason$Enostr = () => new Enostr();
export const SocketReason$isEnostr = (value) => value instanceof Enostr;

export class Enosys extends $CustomType {}
export const SocketReason$Enosys = () => new Enosys();
export const SocketReason$isEnosys = (value) => value instanceof Enosys;

export class Enotblk extends $CustomType {}
export const SocketReason$Enotblk = () => new Enotblk();
export const SocketReason$isEnotblk = (value) => value instanceof Enotblk;

export class Enotdir extends $CustomType {}
export const SocketReason$Enotdir = () => new Enotdir();
export const SocketReason$isEnotdir = (value) => value instanceof Enotdir;

export class Enotsup extends $CustomType {}
export const SocketReason$Enotsup = () => new Enotsup();
export const SocketReason$isEnotsup = (value) => value instanceof Enotsup;

export class Enxio extends $CustomType {}
export const SocketReason$Enxio = () => new Enxio();
export const SocketReason$isEnxio = (value) => value instanceof Enxio;

export class Eopnotsupp extends $CustomType {}
export const SocketReason$Eopnotsupp = () => new Eopnotsupp();
export const SocketReason$isEopnotsupp = (value) => value instanceof Eopnotsupp;

export class Eoverflow extends $CustomType {}
export const SocketReason$Eoverflow = () => new Eoverflow();
export const SocketReason$isEoverflow = (value) => value instanceof Eoverflow;

export class Eperm extends $CustomType {}
export const SocketReason$Eperm = () => new Eperm();
export const SocketReason$isEperm = (value) => value instanceof Eperm;

export class Epipe extends $CustomType {}
export const SocketReason$Epipe = () => new Epipe();
export const SocketReason$isEpipe = (value) => value instanceof Epipe;

export class Erange extends $CustomType {}
export const SocketReason$Erange = () => new Erange();
export const SocketReason$isErange = (value) => value instanceof Erange;

export class Erofs extends $CustomType {}
export const SocketReason$Erofs = () => new Erofs();
export const SocketReason$isErofs = (value) => value instanceof Erofs;

export class Espipe extends $CustomType {}
export const SocketReason$Espipe = () => new Espipe();
export const SocketReason$isEspipe = (value) => value instanceof Espipe;

export class Esrch extends $CustomType {}
export const SocketReason$Esrch = () => new Esrch();
export const SocketReason$isEsrch = (value) => value instanceof Esrch;

export class Estale extends $CustomType {}
export const SocketReason$Estale = () => new Estale();
export const SocketReason$isEstale = (value) => value instanceof Estale;

export class Etxtbsy extends $CustomType {}
export const SocketReason$Etxtbsy = () => new Etxtbsy();
export const SocketReason$isEtxtbsy = (value) => value instanceof Etxtbsy;

export class Exdev extends $CustomType {}
export const SocketReason$Exdev = () => new Exdev();
export const SocketReason$isExdev = (value) => value instanceof Exdev;
