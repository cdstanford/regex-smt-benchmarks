;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^07([\d]{3})[(\D\s)]?[\d]{3}[(\D\s)]?[\d]{3}$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "07081893748"
(define-fun Witness1 () String (str.++ "0" (str.++ "7" (str.++ "0" (str.++ "8" (str.++ "1" (str.++ "8" (str.++ "9" (str.++ "3" (str.++ "7" (str.++ "4" (str.++ "8" ""))))))))))))
;witness2: "07088\u00CC895\xD502"
(define-fun Witness2 () String (str.++ "0" (str.++ "7" (str.++ "0" (str.++ "8" (str.++ "8" (str.++ "\u{cc}" (str.++ "8" (str.++ "9" (str.++ "5" (str.++ "\u{0d}" (str.++ "5" (str.++ "0" (str.++ "2" ""))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (str.to_re (str.++ "0" (str.++ "7" "")))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\u{00}" "/") (re.range ":" "\u{ff}")))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\u{00}" "/") (re.range ":" "\u{ff}")))(re.++ ((_ re.loop 3 3) (re.range "0" "9")) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
