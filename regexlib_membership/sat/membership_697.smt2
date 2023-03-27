;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = &[a-zA-Z]+\d{0,3};
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\x19&K;"
(define-fun Witness1 () String (str.++ "\u{19}" (str.++ "&" (str.++ "K" (str.++ ";" "")))))
;witness2: "L&z;"
(define-fun Witness2 () String (str.++ "L" (str.++ "&" (str.++ "z" (str.++ ";" "")))))

(assert (= regexA (re.++ (re.range "&" "&")(re.++ (re.+ (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ ((_ re.loop 0 3) (re.range "0" "9")) (re.range ";" ";"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
