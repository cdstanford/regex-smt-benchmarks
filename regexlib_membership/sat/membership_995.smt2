;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[^_.]([a-zA-Z0-9_]*[.]?[a-zA-Z0-9_]+[^_]){2}@{1}[a-z0-9]+[.]{1}(([a-z]{2,3})|([a-z]{2,3}[.]{1}[a-z]{2,3}))$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: ").98Q9\u0090.y\u00E8@c.xjp.bsz"
(define-fun Witness1 () String (str.++ ")" (str.++ "." (str.++ "9" (str.++ "8" (str.++ "Q" (str.++ "9" (str.++ "\u{90}" (str.++ "." (str.++ "y" (str.++ "\u{e8}" (str.++ "@" (str.++ "c" (str.++ "." (str.++ "x" (str.++ "j" (str.++ "p" (str.++ "." (str.++ "b" (str.++ "s" (str.++ "z" "")))))))))))))))))))))
;witness2: "\u00A5L\u00FA03\u00C3@c4co9.yyx"
(define-fun Witness2 () String (str.++ "\u{a5}" (str.++ "L" (str.++ "\u{fa}" (str.++ "0" (str.++ "3" (str.++ "\u{c3}" (str.++ "@" (str.++ "c" (str.++ "4" (str.++ "c" (str.++ "o" (str.++ "9" (str.++ "." (str.++ "y" (str.++ "y" (str.++ "x" "")))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.range "\u{00}" "-")(re.union (re.range "/" "^") (re.range "`" "\u{ff}")))(re.++ ((_ re.loop 2 2) (re.++ (re.* (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z")))))(re.++ (re.opt (re.range "." "."))(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))) (re.union (re.range "\u{00}" "^") (re.range "`" "\u{ff}"))))))(re.++ (re.range "@" "@")(re.++ (re.+ (re.union (re.range "0" "9") (re.range "a" "z")))(re.++ (re.range "." ".")(re.++ (re.union ((_ re.loop 2 3) (re.range "a" "z")) (re.++ ((_ re.loop 2 3) (re.range "a" "z"))(re.++ (re.range "." ".") ((_ re.loop 2 3) (re.range "a" "z"))))) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
