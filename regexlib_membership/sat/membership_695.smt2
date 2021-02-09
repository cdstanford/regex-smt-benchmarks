;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = </?[a-z][a-z0-9]*[^<>]*>
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "</x6\u008B^J\u008E%,>"
(define-fun Witness1 () String (seq.++ "<" (seq.++ "/" (seq.++ "x" (seq.++ "6" (seq.++ "\x8b" (seq.++ "^" (seq.++ "J" (seq.++ "\x8e" (seq.++ "%" (seq.++ "," (seq.++ ">" ""))))))))))))
;witness2: "</m>\u007Fr\u0084"
(define-fun Witness2 () String (seq.++ "<" (seq.++ "/" (seq.++ "m" (seq.++ ">" (seq.++ "\x7f" (seq.++ "r" (seq.++ "\x84" ""))))))))

(assert (= regexA (re.++ (re.range "<" "<")(re.++ (re.opt (re.range "/" "/"))(re.++ (re.range "a" "z")(re.++ (re.* (re.union (re.range "0" "9") (re.range "a" "z")))(re.++ (re.* (re.union (re.range "\x00" ";")(re.union (re.range "=" "=") (re.range "?" "\xff")))) (re.range ">" ">"))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
