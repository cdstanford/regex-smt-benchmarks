;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = </?[a-z][a-z0-9]*[^<>]*>
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "</x6\u008B^J\u008E%,>"
(define-fun Witness1 () String (str.++ "<" (str.++ "/" (str.++ "x" (str.++ "6" (str.++ "\u{8b}" (str.++ "^" (str.++ "J" (str.++ "\u{8e}" (str.++ "%" (str.++ "," (str.++ ">" ""))))))))))))
;witness2: "</m>\u007Fr\u0084"
(define-fun Witness2 () String (str.++ "<" (str.++ "/" (str.++ "m" (str.++ ">" (str.++ "\u{7f}" (str.++ "r" (str.++ "\u{84}" ""))))))))

(assert (= regexA (re.++ (re.range "<" "<")(re.++ (re.opt (re.range "/" "/"))(re.++ (re.range "a" "z")(re.++ (re.* (re.union (re.range "0" "9") (re.range "a" "z")))(re.++ (re.* (re.union (re.range "\u{00}" ";")(re.union (re.range "=" "=") (re.range "?" "\u{ff}")))) (re.range ">" ">"))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
