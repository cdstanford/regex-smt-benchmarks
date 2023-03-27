;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (((\[?(?<Database>[\w]+)\]?)?\.)?(\[?(?<Owner>[\w]+)\]?)?\.)?\[?(?<Object>[\w]+)\]?
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\x5\u00C9\u00FE[zH\u0084"
(define-fun Witness1 () String (str.++ "\u{05}" (str.++ "\u{c9}" (str.++ "\u{fe}" (str.++ "[" (str.++ "z" (str.++ "H" (str.++ "\u{84}" ""))))))))
;witness2: "_\u00AA].\u00B5\u00C58.[\u00AA]\u007F"
(define-fun Witness2 () String (str.++ "_" (str.++ "\u{aa}" (str.++ "]" (str.++ "." (str.++ "\u{b5}" (str.++ "\u{c5}" (str.++ "8" (str.++ "." (str.++ "[" (str.++ "\u{aa}" (str.++ "]" (str.++ "\u{7f}" "")))))))))))))

(assert (= regexA (re.++ (re.opt (re.++ (re.opt (re.++ (re.opt (re.++ (re.opt (re.range "[" "["))(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))) (re.opt (re.range "]" "]"))))) (re.range "." ".")))(re.++ (re.opt (re.++ (re.opt (re.range "[" "["))(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))) (re.opt (re.range "]" "]"))))) (re.range "." "."))))(re.++ (re.opt (re.range "[" "["))(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))) (re.opt (re.range "]" "]")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
