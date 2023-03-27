;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?s)/\*.*\*/
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: ";\u00AA/**/"
(define-fun Witness1 () String (str.++ ";" (str.++ "\u{aa}" (str.++ "/" (str.++ "*" (str.++ "*" (str.++ "/" "")))))))
;witness2: "/**/"
(define-fun Witness2 () String (str.++ "/" (str.++ "*" (str.++ "*" (str.++ "/" "")))))

(assert (= regexA (re.++ (str.to_re (str.++ "/" (str.++ "*" "")))(re.++ (re.* (re.range "\u{00}" "\u{ff}")) (str.to_re (str.++ "*" (str.++ "/" "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
