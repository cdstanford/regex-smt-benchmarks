;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[^_.]([a-zA-Z0-9_]*[.]?[a-zA-Z0-9_]+[^_]){2}@{1}[a-z0-9]+[.]{1}(([a-z]{2,3})|([a-z]{2,3}[.]{1}[a-z]{2,3}))$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: ").98Q9\u0090.y\u00E8@c.xjp.bsz"
(define-fun Witness1 () String (seq.++ ")" (seq.++ "." (seq.++ "9" (seq.++ "8" (seq.++ "Q" (seq.++ "9" (seq.++ "\x90" (seq.++ "." (seq.++ "y" (seq.++ "\xe8" (seq.++ "@" (seq.++ "c" (seq.++ "." (seq.++ "x" (seq.++ "j" (seq.++ "p" (seq.++ "." (seq.++ "b" (seq.++ "s" (seq.++ "z" "")))))))))))))))))))))
;witness2: "\u00A5L\u00FA03\u00C3@c4co9.yyx"
(define-fun Witness2 () String (seq.++ "\xa5" (seq.++ "L" (seq.++ "\xfa" (seq.++ "0" (seq.++ "3" (seq.++ "\xc3" (seq.++ "@" (seq.++ "c" (seq.++ "4" (seq.++ "c" (seq.++ "o" (seq.++ "9" (seq.++ "." (seq.++ "y" (seq.++ "y" (seq.++ "x" "")))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.range "\x00" "-")(re.union (re.range "/" "^") (re.range "`" "\xff")))(re.++ ((_ re.loop 2 2) (re.++ (re.* (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z")))))(re.++ (re.opt (re.range "." "."))(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))) (re.union (re.range "\x00" "^") (re.range "`" "\xff"))))))(re.++ (re.range "@" "@")(re.++ (re.+ (re.union (re.range "0" "9") (re.range "a" "z")))(re.++ (re.range "." ".")(re.++ (re.union ((_ re.loop 2 3) (re.range "a" "z")) (re.++ ((_ re.loop 2 3) (re.range "a" "z"))(re.++ (re.range "." ".") ((_ re.loop 2 3) (re.range "a" "z"))))) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
