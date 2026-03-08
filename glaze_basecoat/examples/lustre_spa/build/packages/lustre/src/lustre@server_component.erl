-module(lustre@server_component).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-define(FILEPATH, "src/lustre/server_component.gleam").
-export([element/2, script/0, route/1, method/1, include/2, subject/1, pid/1, register_subject/1, deregister_subject/1, register_callback/1, deregister_callback/1, emit/2, select/1, runtime_message_decoder/0, client_message_to_json/1]).
-export_type([transport_method/0]).

-if(?OTP_RELEASE >= 27).
-define(MODULEDOC(Str), -moduledoc(Str)).
-define(DOC(Str), -doc(Str)).
-else.
-define(MODULEDOC(Str), -compile([])).
-define(DOC(Str), -compile([])).
-endif.

?MODULEDOC(
    " Server components are an advanced feature that allows you to run components\n"
    " or full Lustre applications on the server. Updates are broadcast to a small\n"
    " (10kb!) client runtime that patches the DOM and events are sent back to the\n"
    " server component in real-time.\n"
    "\n"
    " ```text\n"
    " -- SERVER -----------------------------------------------------------------\n"
    "\n"
    "                  Msg                            Element(Msg)\n"
    " +--------+        v        +----------------+        v        +------+\n"
    " |        | <-------------- |                | <-------------- |      |\n"
    " | update |                 | Lustre runtime |                 | view |\n"
    " |        | --------------> |                | --------------> |      |\n"
    " +--------+        ^        +----------------+        ^        +------+\n"
    "         #(model, Effect(msg))  |        ^          Model\n"
    "                                |        |\n"
    "                                |        |\n"
    "                    DOM patches |        | DOM events\n"
    "                                |        |\n"
    "                                v        |\n"
    "                        +-----------------------+\n"
    "                        |                       |\n"
    "                        | Your WebSocket server |\n"
    "                        |                       |\n"
    "                        +-----------------------+\n"
    "                                |        ^\n"
    "                                |        |\n"
    "                    DOM patches |        | DOM events\n"
    "                                |        |\n"
    "                                v        |\n"
    " -- BROWSER ----------------------------------------------------------------\n"
    "                                |        ^\n"
    "                                |        |\n"
    "                    DOM patches |        | DOM events\n"
    "                                |        |\n"
    "                                v        |\n"
    "                            +----------------+\n"
    "                            |                |\n"
    "                            | Client runtime |\n"
    "                            |                |\n"
    "                            +----------------+\n"
    " ```\n"
    "\n"
    " > **Note**: Lustre's server component runtime is separate from your application's\n"
    " > WebSocket server. You're free to bring your own stack, connect multiple\n"
    " > clients to the same Lustre instance, or keep the application alive even when\n"
    " > no clients are connected.\n"
    "\n"
    " Lustre server components run next to the rest of your backend code, your\n"
    " services, your database, etc. Real-time applications like chat services, games,\n"
    " or components that can benefit from direct access to your backend services\n"
    " like an admin dashboard or data table are excellent candidates for server\n"
    " components.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " Server components are a new feature in Lustre and we're still working on the\n"
    " best ways to use them and show them off. Here are a few examples we've\n"
    " developed so far:\n"
    "\n"
    " - [Basic setup](https://github.com/lustre-labs/lustre/tree/main/examples/06-server-components/01-basic-setup)\n"
    "\n"
    " - [Custom attributes and events](https://github.com/lustre-labs/lustre/tree/main/examples/06-server-components/02-attributes-and-events)\n"
    "\n"
    " - [Decoding DOM events](https://github.com/lustre-labs/lustre/tree/main/examples/06-server-components/03-event-include)\n"
    "\n"
    " - [Connecting more than one client](https://github.com/lustre-labs/lustre/tree/main/examples/06-server-components/04-multiple-clients)\n"
    "\n"
    " - [Adding publish-subscribe](https://github.com/lustre-labs/lustre/tree/main/examples/06-server-components/05-publish-subscribe)\n"
    "\n"
    " ## Getting help\n"
    "\n"
    " If you're having trouble with Lustre or not sure what the right way to do\n"
    " something is, the best place to get help is the [Gleam Discord server](https://discord.gg/Fm8Pwmy).\n"
    " You could also open an issue on the [Lustre GitHub repository](https://github.com/lustre-labs/lustre/issues).\n"
    "\n"
).

-type transport_method() :: web_socket | server_sent_events | polling.

-file("src/lustre/server_component.gleam", 143).
?DOC(
    " Render the server component custom element. This element acts as the thin\n"
    " client runtime for a server component running remotely. There are a handful\n"
    " of attributes you should provide to configure the client runtime:\n"
    "\n"
    " - [`route`](#route) is the URL your server component should connect to. This\n"
    "   **must** be provided before the client runtime will do anything. The route\n"
    "   can be a relative URL, in which case it will be resolved against the current\n"
    "   page URL.\n"
    "\n"
    " - [`method`](#method) is the transport method the client runtime should use.\n"
    "   This defaults to `WebSocket` enabling duplex communication between the client\n"
    "   and server runtime. Other options include `ServerSentEvents` and `Polling`\n"
    "   which are unidirectional transports.\n"
    "\n"
    " > **Note**: the server component runtime bundle must be included and sent to\n"
    " > the client for this to work correctly. You can do this by including the\n"
    " > JavaScript bundle found in Lustre's `priv/static` directory or by inlining\n"
    " > the script source directly with the [`script`](#script) element below.\n"
).
-spec element(
    list(lustre@vdom@vattr:attribute(YZT)),
    list(lustre@vdom@vnode:element(YZT))
) -> lustre@vdom@vnode:element(YZT).
element(Attributes, Children) ->
    lustre@element:element(
        <<"lustre-server-component"/utf8>>,
        Attributes,
        Children
    ).

-file("src/lustre/server_component.gleam", 155).
?DOC(
    " Inline the server component client runtime as a `<script>` tag. Where possible\n"
    " you should prefer serving the pre-built client runtime from Lustre's `priv/static`\n"
    " directory, but this inline script can be useful for development or scenarios\n"
    " where you don't control the HTML document.\n"
).
-spec script() -> lustre@vdom@vnode:element(any()).
script() ->
    lustre@element@html:script(
        [lustre@attribute:type_(<<"module"/utf8>>)],
        <<"function $e(s){return s.replaceAll(/[><&\"']/g,e=>{switch(e){case\">\":return\"&gt;\";case\"<\":return\"&lt;\";case\"'\":return\"&#39;\";case\"&\":return\"&amp;\";case'\"':return\"&quot;\";default:return e}})}function ge(s){return $e(s)}function D(s){return ge(s)}var Z=s=>s.head,q=s=>s.tail;var Bt=5,Kn=(1<<Bt)-1,Xn=Symbol(),Yn=Symbol();var Ae=[\" \",\"	\",`\\n`,\"\\v\",\"\\f\",\"\\r\",\"\\x85\",\"\\u2028\",\"\\u2029\"].join(\"\"),Jr=new RegExp(`^[${Ae}]*`),Qr=new RegExp(`[${Ae}]*$`);var He=0,Ve=1,Ge=2,We=0;var le=2;var W=0,J=1,ce=2,Je=3,N=4,Qe=5;var Ke=0,Xe=1,Ye=2,Ze=3,et=4,tt=5,nt=6;var it=\"	\",st=\"\\r\";var b=(s,e)=>{if(Array.isArray(s))for(let t=0;t<s.length;t++)e(s[t]);else if(s)for(s;q(s);s=q(s))e(Z(s))};var ue=\"http://www.w3.org/1999/xhtml\";var lt=!!globalThis.HTMLElement?.prototype?.moveBefore;var xn=globalThis.setTimeout,ae=globalThis.clearTimeout,$n=(s,e)=>globalThis.document.createElementNS(s,e),ct=s=>globalThis.document.createTextNode(s),ut=s=>globalThis.document.createComment(s),gn=()=>globalThis.document.createDocumentFragment(),k=(s,e,t)=>s.insertBefore(e,t),at=lt?(s,e,t)=>s.moveBefore(e,t):k,ft=(s,e)=>s.removeChild(e),bn=(s,e)=>s.getAttribute(e),pt=(s,e,t)=>s.setAttribute(e,t),wn=(s,e)=>s.removeAttribute(e),yn=(s,e,t,r)=>s.addEventListener(e,t,r),dt=(s,e,t)=>s.removeEventListener(e,t),kn=(s,e)=>s.innerHTML=e,vn=(s,e)=>s.data=e,m=Symbol(\"lustre\"),pe=class{constructor(e,t,r,n){this.kind=e,this.key=n,this.parent=t,this.children=[],this.node=r,this.endNode=null,this.handlers=new Map,this.throttles=new Map,this.debouncers=new Map}get isVirtual(){return this.kind===W||this.kind===N}get parentNode(){return this.isVirtual?this.node.parentNode:this.node}};var I=(s,e,t,r,n)=>{let l=new pe(s,e,t,n);return t[m]=l,e?.children.splice(r,0,l),l},En=s=>{let e=\"\";for(let t=s[m];t.parent;t=t.parent){let r=t.parent&&t.parent.kind===N?st:it;if(t.key)e=`${r}${t.key}${e}`;else{let n=t.parent.children.indexOf(t);e=`${r}${n}${e}`}}return e.slice(1)},U=class{#r=null;#t;#n;#e=!1;constructor(e,t,r,{debug:n=!1}={}){this.#r=e,this.#t=t,this.#n=r,this.#e=n}mount(e){I(J,null,this.#r,0,null),this.#h(this.#r,null,this.#r[m],0,e)}push(e,t=null){this.#s=t,this.#i.push({node:this.#r[m],patch:e}),this.#o()}#s;#i=[];#o(){let e=this.#i;for(;e.length;){let{node:t,patch:r}=e.pop(),{children:n}=t,{changes:l,removed:i,children:o}=r;b(l,c=>this.#l(t,c)),i&&this.#d(t,n.length-i,i),b(o,c=>{let a=n[c.index|0];this.#i.push({node:a,patch:c})})}}#l(e,t){switch(t.kind){case Ke:this.#E(e,t);break;case Xe:this.#b(e,t);break;case Ye:this.#v(e,t);break;case Ze:this.#f(e,t);break;case et:this.#x(e,t);break;case tt:this.#u(e,t);break;case nt:this.#c(e,t);break}}#c(e,{children:t,before:r}){let n=gn(),l=this.#a(e,r);this.#$(n,null,e,r|0,t),k(e.parentNode,n,l)}#u(e,{index:t,with:r}){this.#d(e,t|0,1);let n=this.#a(e,t);this.#h(e.parentNode,n,e,t|0,r)}#a(e,t){t=t|0;let{children:r}=e,n=r.length;if(t<n)return r[t].node;if(e.endNode)return e.endNode;if(!e.isVirtual)return null;for(;e.isVirtual&&e.children.length;){if(e.endNode)return e.endNode.nextSibling;e=e.children[e.children.length-1]}return e.node.nextSibling}#f(e,{key:t,before:r}){r=r|0;let{children:n,parentNode:l}=e,i=n[r].node,o=n[r];for(let c=r+1;c<n.length;++c){let a=n[c];if(n[c]=o,o=a,a.key===t){n[r]=a;break}}this.#p(l,o,i)}#m(e,t,r){for(let n=0;n<t.length;++n)this.#p(e,t[n],r)}#p(e,t,r){at(e,t.node,r),t.isVirtual&&this.#m(e,t.children,r),t.endNode&&at(e,t.endNode,r)}#x(e,{index:t}){this.#d(e,t,1)}#d(e,t,r){let{children:n,parentNode:l}=e,i=n.splice(t,r);for(let o=0;o<i.length;++o){let c=i[o],{node:a,endNode:w,isVirtual:v,children:p}=c;ft(l,a),w&&ft(l,w),this.#g(c),v&&i.push(...p)}}#g(e){let{debouncers:t,children:r}=e;for(let{timeout:n}of t.values())n&&ae(n);t.clear(),b(r,n=>this.#g(n))}#v({node:e,handlers:t,throttles:r,debouncers:n},{added:l,removed:i}){b(i,({name:o})=>{t.delete(o)?(dt(e,o,fe),this.#_(r,o,0),this.#_(n,o,0)):(wn(e,o),_t[o]?.removed?.(e,o))}),b(l,o=>this.#k(e,o))}#E({node:e},{content:t}){vn(e,t??\"\")}#b({node:e},{inner_html:t}){kn(e,t??\"\")}#$(e,t,r,n,l){b(l,i=>this.#h(e,t,r,n++,i))}#h(e,t,r,n,l){switch(l.kind){case J:{let i=this.#w(r,n,l);this.#$(i,null,i[m],0,l.children),k(e,i,t);break}case ce:{let i=this.#j(r,n,l);k(e,i,t);break}case W:{let i=\"lustre:fragment\",o=this.#y(i,r,n,l);k(e,o,t),this.#$(e,t,o[m],0,l.children),this.#e&&(o[m].endNode=ut(` /${i} `),k(e,o[m].endNode,t));break}case Je:{let i=this.#w(r,n,l);this.#b({node:i},l),k(e,i,t);break}case N:{let i=this.#y(\"lustre:map\",r,n,l);k(e,i,t),this.#h(e,t,i[m],0,l.child);break}case Qe:{let i=this.#s?.get(l.view)??l.view();this.#h(e,t,r,n,i);break}}}#w(e,t,{kind:r,key:n,tag:l,namespace:i,attributes:o}){let c=$n(i||ue,l);return I(r,e,c,t,n),this.#e&&n&&pt(c,\"data-lustre-key\",n),b(o,a=>this.#k(c,a)),c}#j(e,t,{kind:r,key:n,content:l}){let i=ct(l??\"\");return I(r,e,i,t,n),i}#y(e,t,r,{kind:n,key:l}){let i=this.#e?ut(jn(e,l)):ct(\"\");return I(n,t,i,r,l),i}#k(e,t){let{debouncers:r,handlers:n,throttles:l}=e[m],{kind:i,name:o,value:c,prevent_default:a,debounce:w,throttle:v}=t;switch(i){case He:{let p=c??\"\";if(o===\"virtual:defaultValue\"){e.defaultValue=p;return}else if(o===\"virtual:defaultChecked\"){e.defaultChecked=!0;return}else if(o===\"virtual:defaultSelected\"){e.defaultSelected=!0;return}p!==bn(e,o)&&pt(e,o,p),_t[o]?.added?.(e,p);break}case Ve:e[o]=c;break;case Ge:{n.has(o)&&dt(e,o,fe);let p=a.kind===We;yn(e,o,fe,{passive:p}),this.#_(l,o,v),this.#_(r,o,w),n.set(o,E=>this.#C(t,E));break}}}#_(e,t,r){let n=e.get(t);if(r>0)n?n.delay=r:e.set(t,{delay:r});else if(n){let{timeout:l}=n;l&&ae(l),e.delete(t)}}#C(e,t){let{currentTarget:r,type:n}=t,{debouncers:l,throttles:i}=r[m],o=En(r),{prevent_default:c,stop_propagation:a,include:w}=e;c.kind===le&&t.preventDefault(),a.kind===le&&t.stopPropagation(),n===\"submit\"&&(t.detail??={},t.detail.formData=[...new FormData(t.target,t.submitter).entries()]);let v=this.#t(t,o,n,w),p=i.get(n);if(p){let xe=Date.now(),Ct=p.last||0;xe>Ct+p.delay&&(p.last=xe,p.lastEvent=t,this.#n(t,v))}let E=l.get(n);E&&(ae(E.timeout),E.timeout=xn(()=>{t!==i.get(n)?.lastEvent&&this.#n(t,v)},E.delay)),!p&&!E&&this.#n(t,v)}},jn=(s,e)=>e?` ${s} key=\"${D(e)}\" `:` ${s} `,fe=s=>{let{currentTarget:e,type:t}=s;e[m].handlers.get(t)(s)},ht=s=>({added(e){e[s]=!0},removed(e){e[s]=!1}}),Cn=s=>({added(e,t){e[s]=t}}),_t={checked:ht(\"checked\"),selected:ht(\"selected\"),value:Cn(\"value\"),autofocus:{added(s){queueMicrotask(()=>{s.focus?.()})}},autoplay:{added(s){try{s.play?.()}catch(e){console.error(e)}}}};var $t=new WeakMap;async function gt(s){let e=[];for(let r of globalThis.document.querySelectorAll(\"link[rel=stylesheet], style\"))r.sheet||e.push(new Promise((n,l)=>{r.addEventListener(\"load\",n),r.addEventListener(\"error\",l)}));if(await Promise.allSettled(e),!s.host.isConnected)return[];s.adoptedStyleSheets=s.host.getRootNode().adoptedStyleSheets;let t=[];for(let r of globalThis.document.styleSheets)try{s.adoptedStyleSheets.push(r)}catch{try{let n=$t.get(r);if(!n){n=new CSSStyleSheet;for(let l of r.cssRules)n.insertRule(l.cssText,n.cssRules.length);$t.set(r,n)}s.adoptedStyleSheets.push(n)}catch{let n=r.ownerNode.cloneNode();s.prepend(n),t.push(n)}}return t}var K=class extends Event{constructor(e,t,r){super(\"context-request\",{bubbles:!0,composed:!0}),this.context=e,this.callback=t,this.subscribe=r}};var bt=0,wt=1,yt=2,kt=3,X=0,vt=1,Et=2,Y=3,jt=4;var de=class extends HTMLElement{static get observedAttributes(){return[\"route\",\"method\"]}#r;#t=\"ws\";#n=null;#e=null;#s=[];#i;#o=new Set;#l=new Set;#c=!1;#u=[];#a=new Map;#f=new Set;#m=new MutationObserver(e=>{let t=[];for(let r of e){if(r.type!==\"attributes\")continue;let n=r.attributeName;(!this.#c||this.#o.has(n))&&t.push([n,this.getAttribute(n)])}if(t.length===1){let[r,n]=t[0];this.#e?.send({kind:X,name:r,value:n})}else t.length?this.#e?.send({kind:Y,messages:t.map(([r,n])=>({kind:X,name:r,value:n}))}):this.#u.push(...t)});constructor(){super(),this.internals=this.attachInternals(),this.#m.observe(this,{attributes:!0})}connectedCallback(){for(let e of this.attributes)this.#u.push([e.name,e.value])}attributeChangedCallback(e,t,r){switch(e){case(t!==r&&\"route\"):{this.#n=new URL(r,location.href),this.#p();return}case\"method\":{let n=r.toLowerCase();if(n==this.#t)return;[\"ws\",\"sse\",\"polling\"].includes(n)&&(this.#t=n,this.#t==\"ws\"&&(this.#n.protocol==\"https:\"&&(this.#n.protocol=\"wss:\"),this.#n.protocol==\"http:\"&&(this.#n.protocol=\"ws:\")),this.#p());return}}}async messageReceivedCallback(e){switch(e.kind){case bt:{for(this.#r??=this.attachShadow({mode:e.open_shadow_root?\"open\":\"closed\"});this.#r.firstChild;)this.#r.firstChild.remove();let t=(i,o,c,a)=>{let w=this.#d(i,a??[]);return{kind:vt,path:o,name:c,event:w}},r=(i,o)=>{this.#e?.send(o)};this.#i=new U(this.#r,t,r),this.#o=new Set(e.observed_attributes);let l=this.#u.filter(([i])=>this.#o.has(i)).map(([i,o])=>({kind:X,name:i,value:o}));this.#u=[],this.#l=new Set(e.observed_properties);for(let i of this.#l)Object.defineProperty(this,i,{get(){return this[`_${i}`]},set(o){this[`_${i}`]=o,this.#e?.send({kind:Et,name:i,value:o})}});for(let[i,o]of Object.entries(e.provided_contexts))this.provide(i,o);for(let i of[...new Set(e.requested_contexts)])this.dispatchEvent(new K(i,(o,c)=>{this.#e?.send({kind:jt,key:i,value:o}),this.#f.add(c)}));l.length&&this.#e.send({kind:Y,messages:l}),e.will_adopt_styles&&await this.#x(),this.#r.addEventListener(\"context-request\",i=>{if(!i.context||!i.callback||!this.#a.has(i.context))return;i.stopImmediatePropagation();let o=this.#a.get(i.context);if(i.subscribe){let c=()=>{o.subscribers=o.subscribers.filter(a=>a!==i.callback)};o.subscribers.push([i.callback,c]),i.callback(o.value,c)}else i.callback(o.value)}),this.#i.mount(e.vdom),this.dispatchEvent(new CustomEvent(\"lustre:mount\"));break}case wt:{this.#i.push(e.patch);break}case yt:{this.dispatchEvent(new CustomEvent(e.name,{detail:e.data}));break}case kt:{this.provide(e.key,e.value);break}}}disconnectedCallback(){for(let e of this.#f)e();this.#f.clear(),this.#e&&(this.#e.close(),this.#e=null)}provide(e,t){if(!this.#a.has(e))this.#a.set(e,{value:t,subscribers:[]});else{let r=this.#a.get(e);r.value=t;for(let n=r.subscribers.length-1;n>=0;n--){let[l,i]=r.subscribers[n];if(!l){r.subscribers.splice(n,1);continue}l(t,i)}}}#p(){if(!this.#n||!this.#t)return;this.#e&&this.#e.close();let n={onConnect:()=>{this.#c=!0,this.dispatchEvent(new CustomEvent(\"lustre:connect\"),{detail:{route:this.#n,method:this.#t}})},onMessage:l=>{this.messageReceivedCallback(l)},onClose:()=>{this.#c=!1,this.dispatchEvent(new CustomEvent(\"lustre:close\",{detail:{route:this.#n,method:this.#t}}))}};switch(this.#t){case\"ws\":this.#e=new he(this.#n,n);break;case\"sse\":this.#e=new _e(this.#n,n);break;case\"polling\":this.#e=new me(this.#n,n);break}}async#x(){for(;this.#s.length;)this.#s.pop().remove(),this.#r.firstChild.remove();this.#s=await gt(this.#r)}#d(e,t=[]){let r={};(e.type===\"input\"||e.type===\"change\")&&(e.target.type===\"checkbox\"?t.push(\"target.checked\"):t.push(\"target.value\")),(e.type===\"keydown\"||e.type===\"keyup\"||e.type===\"keypress\")&&t.push(\"key\"),e.type===\"submit\"&&t.push(\"detail.formData\");for(let n of t){let l=n.split(\".\");for(let i=0,o=e,c=r;i<l.length;i++){if(i===l.length-1){c[l[i]]=o[l[i]];break}c=c[l[i]]??={},o=o[l[i]]}}return r}},he=class{#r;#t;#n=!1;#e=[];#s=!0;#i=500;#o=1e4;#l;#c;#u;constructor(e,{onConnect:t,onMessage:r,onClose:n}){this.#r=e,this.#l=t,this.#c=r,this.#u=n,this.#a()}#a(){this.#t=new WebSocket(this.#r),this.#s=!0,this.#e=[],this.#t.onopen=()=>{this.#i=500,this.#l()},this.#t.onmessage=({data:e})=>{try{this.#c(JSON.parse(e))}finally{this.#e.length?this.#t.send(JSON.stringify({kind:Y,messages:this.#e})):this.#n=!1,this.#e=[]}},this.#t.onclose=e=>{this.#u(),e.code!==1e3&&this.#s&&this.#f()}}#f(){let e=()=>{this.#s&&(this.#a(),this.#i=Math.min(this.#i*2,this.#o))};if(document.hidden){let t=()=>{!document.hidden&&this.#s&&(document.removeEventListener(\"visibilitychange\",t),e())};document.addEventListener(\"visibilitychange\",t)}else setTimeout(e,this.#i)}send(e){if(!(!this.#t||this.#t.readyState!==WebSocket.OPEN))if(this.#n){this.#e.push(e);return}else this.#t.send(JSON.stringify(e)),this.#n=!0}close(){this.#s=!1,this.#t.close(1e3),this.#t=null}},_e=class{#r;#t;#n=!0;#e=500;#s=1e4;#i;#o;#l;constructor(e,{onConnect:t,onMessage:r,onClose:n}){this.#r=e,this.#i=t,this.#o=r,this.#l=n,this.#c()}#c(){this.#t=new EventSource(this.#r),this.#e=500,this.#n=!0,this.#t.onopen=()=>{this.#i()},this.#t.onmessage=({data:e})=>{try{this.#o(JSON.parse(e))}catch{}},this.#t.onerror=()=>{this.#t.close(),this.#l(),this.#n&&this.#u()}}#u(){let e=()=>{this.#n&&(this.#c(),this.#e=Math.min(this.#e*2,this.#s))};if(document.hidden){let t=()=>{!document.hidden&&this.#n&&(document.removeEventListener(\"visibilitychange\",t),e())};document.addEventListener(\"visibilitychange\",t)}else setTimeout(e,this.#e)}send(e){}close(){this.#n=!1,this.#t.close(),this.#l()}},me=class{#r;#t;#n;#e;#s;#i;constructor(e,{onConnect:t,onMessage:r,onClose:n,...l}){this.#r=e,this.#e=t,this.#s=r,this.#i=n,this.#t=l.interval??5e3,this.#o().finally(()=>{this.#e(),this.#n=setInterval(()=>this.#o(),this.#t)})}async send(e){}close(){clearInterval(this.#n),this.#i()}#o(){return fetch(this.#r).then(e=>e.json()).then(this.#s).catch(console.error)}};customElements.define(\"lustre-server-component\",de);export{de as ServerComponent};"/utf8>>
    ).

-file("src/lustre/server_component.gleam", 170).
?DOC(
    " The `route` attribute tells the client runtime what route it should use to\n"
    " set up the WebSocket connection to the server. Whenever this attribute is\n"
    " changed (by a clientside Lustre app, for example), the client runtime will\n"
    " destroy the current connection and set up a new one.\n"
).
-spec route(binary()) -> lustre@vdom@vattr:attribute(any()).
route(Path) ->
    lustre@attribute:attribute(<<"route"/utf8>>, Path).

-file("src/lustre/server_component.gleam", 176).
?DOC("\n").
-spec method(transport_method()) -> lustre@vdom@vattr:attribute(any()).
method(Value) ->
    lustre@attribute:attribute(<<"method"/utf8>>, case Value of
            web_socket ->
                <<"ws"/utf8>>;

            server_sent_events ->
                <<"sse"/utf8>>;

            polling ->
                <<"polling"/utf8>>
        end).

-file("src/lustre/server_component.gleam", 213).
?DOC(
    " Properties of a JavaScript event object are typically not serialisable. This\n"
    " means if we want to send them to the server we need to make a copy of any\n"
    " fields we want to decode first.\n"
    "\n"
    " This attribute tells Lustre what properties to include from an event. Properties\n"
    " can come from nested fields by using dot notation. For example, you could include\n"
    " the\n"
    " `id` of the target `element` by passing `[\"target.id\"]`.\n"
    "\n"
    " ```gleam\n"
    " import gleam/dynamic/decode\n"
    " import lustre/element.{type Element}\n"
    " import lustre/element/html\n"
    " import lustre/event\n"
    " import lustre/server_component\n"
    "\n"
    " pub fn custom_button(on_click: fn(String) -> msg) -> Element(msg) {\n"
    "   let handler = fn(event) {\n"
    "     use id <- decode.at([\"target\", \"id\"], decode.string)\n"
    "     decode.success(on_click(id))\n"
    "   }\n"
    "\n"
    "   html.button(\n"
    "     [server_component.include([\"target.id\"]), event.on(\"click\", handler)],\n"
    "     [html.text(\"Click me!\")],\n"
    "   )\n"
    " }\n"
    " ```\n"
).
-spec include(lustre@vdom@vattr:attribute(AAAF), list(binary())) -> lustre@vdom@vattr:attribute(AAAF).
include(Event, Properties) ->
    case Event of
        {event, _, _, _, _, _, _, _, _} ->
            {event,
                erlang:element(2, Event),
                erlang:element(3, Event),
                erlang:element(4, Event),
                Properties,
                erlang:element(6, Event),
                erlang:element(7, Event),
                erlang:element(8, Event),
                erlang:element(9, Event)};

        _ ->
            Event
    end.

-file("src/lustre/server_component.gleam", 233).
?DOC(
    " Recover the `Subject` of the server component runtime so that it can be used\n"
    " in supervision trees or passed to other processes. If you want to hand out\n"
    " different `Subject`s to send messages to your application, take a look at the\n"
    " [`select`](#select) effect.\n"
    "\n"
    " > **Note**: this function is not available on the JavaScript target.\n"
).
-spec subject(lustre:runtime(AAAJ)) -> gleam@erlang@process:subject(lustre@runtime@server@runtime:message(AAAJ)).
subject(Runtime) ->
    gleam@function:identity(Runtime).

-file("src/lustre/server_component.gleam", 245).
?DOC(
    " Recover the `Pid` of the server component runtime so that it can be used in\n"
    " supervision trees or passed to other processes. If you want to hand out\n"
    " different `Subject`s to send messages to your application, take a look at the\n"
    " [`select`](#select) effect.\n"
    "\n"
    " > **Note**: this function is not available on the JavaScript target.\n"
).
-spec pid(lustre:runtime(any())) -> gleam@erlang@process:pid_().
pid(Runtime) ->
    Pid@1 = case gleam@erlang@process:subject_owner(subject(Runtime)) of
        {ok, Pid} -> Pid;
        _assert_fail ->
            erlang:error(#{gleam_error => let_assert,
                        message => <<"Pattern match failed, no pattern matched the value."/utf8>>,
                        file => <<?FILEPATH/utf8>>,
                        module => <<"lustre/server_component"/utf8>>,
                        function => <<"pid"/utf8>>,
                        line => 246,
                        value => _assert_fail,
                        start => 23602,
                        'end' => 23662,
                        pattern_start => 23613,
                        pattern_end => 23620})
    end,
    Pid@1.

-file("src/lustre/server_component.gleam", 262).
?DOC(
    " Register a `Subject` to receive messages and updates from Lustre's server\n"
    " component runtime. The process that owns this will be monitored and the\n"
    " subject will be gracefully removed if the process dies.\n"
    "\n"
    " > **Note**: if you are developing a server component for the JavaScript runtime,\n"
    " > you should use [`register_callback`](#register_callback) instead.\n"
).
-spec register_subject(
    gleam@erlang@process:subject(lustre@runtime@transport:client_message(AAAR))
) -> lustre@runtime@server@runtime:message(AAAR).
register_subject(Client) ->
    {client_registered_subject, Client}.

-file("src/lustre/server_component.gleam", 272).
?DOC(
    " Deregister a `Subject` to stop receiving messages and updates from Lustre's\n"
    " server component runtime. The subject should first have been registered with\n"
    " [`register_subject`](#register_subject) otherwise this will do nothing.\n"
).
-spec deregister_subject(
    gleam@erlang@process:subject(lustre@runtime@transport:client_message(AAAV))
) -> lustre@runtime@server@runtime:message(AAAV).
deregister_subject(Client) ->
    {client_deregistered_subject, Client}.

-file("src/lustre/server_component.gleam", 286).
?DOC(
    " Register a callback to be called whenever the server component runtime\n"
    " produces a message. Avoid using anonymous functions with this function, as\n"
    " they cannot later be removed using [`deregister_callback`](#deregister_callback).\n"
    "\n"
    " > **Note**: server components running on the Erlang target are **strongly**\n"
    " > encouraged to use [`register_subject`](#register_subject) instead of this\n"
    " > function.\n"
).
-spec register_callback(
    fun((lustre@runtime@transport:client_message(AAAZ)) -> nil)
) -> lustre@runtime@server@runtime:message(AAAZ).
register_callback(Callback) ->
    {client_registered_callback, Callback}.

-file("src/lustre/server_component.gleam", 300).
?DOC(
    " Deregister a callback to be called whenever the server component runtime\n"
    " produces a message. The callback to remove is determined by function equality\n"
    " and must be the same function that was passed to [`register_callback`](#register_callback).\n"
    "\n"
    " > **Note**: server components running on the Erlang target are **strongly**\n"
    " > encouraged to use [`register_subject`](#register_subject) instead of this\n"
    " > function.\n"
).
-spec deregister_callback(
    fun((lustre@runtime@transport:client_message(AABC)) -> nil)
) -> lustre@runtime@server@runtime:message(AABC).
deregister_callback(Callback) ->
    {client_deregistered_callback, Callback}.

-file("src/lustre/server_component.gleam", 316).
?DOC(
    " Instruct any connected clients to emit a DOM event with the given name and\n"
    " data. This lets your server component communicate to the frontend the same way\n"
    " any other HTML elements do: you might emit a `\"change\"` event when some part\n"
    " of the server component's state changes, for example.\n"
    "\n"
    " This is a real DOM event and any JavaScript on the page can attach an event\n"
    " listener to the server component element and listen for these events.\n"
).
-spec emit(binary(), gleam@json:json()) -> lustre@effect:effect(any()).
emit(Event, Data) ->
    lustre@effect:event(Event, Data).

-file("src/lustre/server_component.gleam", 339).
?DOC(
    " On the Erlang target, Lustre's server component runtime is an OTP\n"
    " [actor](https://hexdocs.pm/gleam_otp/gleam/otp/actor.html) that can be\n"
    " communicated with using the standard process API and the `Subject` returned\n"
    " when starting the server component.\n"
    "\n"
    " Sometimes, you might want to hand a different `Subject` to a process to restrict\n"
    " the type of messages it can send or to distinguish messages from different\n"
    " sources from one another. The `select` effect creates a fresh `Subject` each\n"
    " time it is run. By returning a `Selector` you can teach the Lustre server\n"
    " component runtime how to listen to messages from this `Subject`.\n"
    "\n"
    " The `select` effect also gives you the dispatch function passed to `effect.from`.\n"
    " This is useful in case you want to store the provided `Subject` in your model\n"
    " for later use. For example you may subscribe to a pubsub service and later use\n"
    " that same `Subject` to unsubscribe.\n"
    "\n"
    " > **Note**: This effect does nothing on the JavaScript runtime, where `Subject`s\n"
    " > and `Selector`s don't exist, and is the equivalent of returning `effect.none()`.\n"
).
-spec select(
    fun((fun((AABH) -> nil), gleam@erlang@process:subject(any())) -> gleam@erlang@process:selector(AABH))
) -> lustre@effect:effect(AABH).
select(Sel) ->
    lustre@effect:select(Sel).

-file("src/lustre/server_component.gleam", 352).
?DOC(
    " The server component client runtime sends JSON-encoded messages for the server\n"
    " runtime to execute. Because your own WebSocket server sits between the two\n"
    " parts of the runtime, you need to decode these actions and pass them to the\n"
    " server runtime yourself.\n"
).
-spec runtime_message_decoder() -> gleam@dynamic@decode:decoder(lustre@runtime@server@runtime:message(any())).
runtime_message_decoder() ->
    gleam@dynamic@decode:map(
        lustre@runtime@transport:server_message_decoder(),
        fun(Field@0) -> {client_dispatched_message, Field@0} end
    ).

-file("src/lustre/server_component.gleam", 368).
?DOC(
    " Encode a message you can send to the client runtime to respond to. The server\n"
    " component runtime will send messages to any registered clients to instruct\n"
    " them to update their DOM or emit events, for example.\n"
    "\n"
    " Because your WebSocket server sits between the two parts of the runtime, you\n"
    " need to encode these actions and send them to the client runtime yourself.\n"
).
-spec client_message_to_json(lustre@runtime@transport:client_message(any())) -> gleam@json:json().
client_message_to_json(Message) ->
    lustre@runtime@transport:client_message_to_json(Message).
