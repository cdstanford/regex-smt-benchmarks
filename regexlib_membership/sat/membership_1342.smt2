;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?<dice>\d*)(?<dsides>(?<separator>[\d\D])(?<sides>\d+))(?<modifier>(?<sign>[\+\-])(?<addend>\d))?
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00C0f097"
(define-fun Witness1 () String (str.++ "\u{c0}" (str.++ "f" (str.++ "0" (str.++ "9" (str.++ "7" ""))))))
;witness2: ",95"
(define-fun Witness2 () String (str.++ "," (str.++ "9" (str.++ "5" ""))))

(assert (= regexA (re.++ (re.* (re.range "0" "9"))(re.++ (re.++ (re.range "\u{00}" "\u{ff}") (re.+ (re.range "0" "9"))) (re.opt (re.++ (re.union (re.range "+" "+") (re.range "-" "-")) (re.range "0" "9")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
