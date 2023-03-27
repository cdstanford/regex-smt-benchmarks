;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ((DK|FI|HU|LU|MT|SI)(-)?\d{8})|((BE|EE|DE|EL|LT|PT)(-)?\d{9})|((PL|SK)(-)?\d{10})|((IT|LV)(-)?\d{11})|((LT|SE)(-)?\d{12})|(AT(-)?U\d{8})|(CY(-)?\d{8}[A-Z])|(CZ(-)?\d{8,10})|(FR(-)?[\dA-HJ-NP-Z]{2}\d{9})|(IE(-)?\d[A-Z\d]\d{5}[A-Z])|(NL(-)?\d{9}B\d{2})|(ES(-)?[A-Z\d]\d{7}[A-Z\d])
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\x13NL-999989474B68\u00B7"
(define-fun Witness1 () String (str.++ "\u{13}" (str.++ "N" (str.++ "L" (str.++ "-" (str.++ "9" (str.++ "9" (str.++ "9" (str.++ "9" (str.++ "8" (str.++ "9" (str.++ "4" (str.++ "7" (str.++ "4" (str.++ "B" (str.++ "6" (str.++ "8" (str.++ "\u{b7}" ""))))))))))))))))))
;witness2: "7CZ-99868836\u00A1\x1DJ\u00CC\u0096"
(define-fun Witness2 () String (str.++ "7" (str.++ "C" (str.++ "Z" (str.++ "-" (str.++ "9" (str.++ "9" (str.++ "8" (str.++ "6" (str.++ "8" (str.++ "8" (str.++ "3" (str.++ "6" (str.++ "\u{a1}" (str.++ "\u{1d}" (str.++ "J" (str.++ "\u{cc}" (str.++ "\u{96}" ""))))))))))))))))))

(assert (= regexA (re.union (re.++ (re.union (str.to_re (str.++ "D" (str.++ "K" "")))(re.union (str.to_re (str.++ "F" (str.++ "I" "")))(re.union (str.to_re (str.++ "H" (str.++ "U" "")))(re.union (str.to_re (str.++ "L" (str.++ "U" "")))(re.union (str.to_re (str.++ "M" (str.++ "T" ""))) (str.to_re (str.++ "S" (str.++ "I" ""))))))))(re.++ (re.opt (re.range "-" "-")) ((_ re.loop 8 8) (re.range "0" "9"))))(re.union (re.++ (re.union (str.to_re (str.++ "B" (str.++ "E" "")))(re.union (str.to_re (str.++ "E" (str.++ "E" "")))(re.union (str.to_re (str.++ "D" (str.++ "E" "")))(re.union (str.to_re (str.++ "E" (str.++ "L" "")))(re.union (str.to_re (str.++ "L" (str.++ "T" ""))) (str.to_re (str.++ "P" (str.++ "T" ""))))))))(re.++ (re.opt (re.range "-" "-")) ((_ re.loop 9 9) (re.range "0" "9"))))(re.union (re.++ (re.union (str.to_re (str.++ "P" (str.++ "L" ""))) (str.to_re (str.++ "S" (str.++ "K" ""))))(re.++ (re.opt (re.range "-" "-")) ((_ re.loop 10 10) (re.range "0" "9"))))(re.union (re.++ (re.union (str.to_re (str.++ "I" (str.++ "T" ""))) (str.to_re (str.++ "L" (str.++ "V" ""))))(re.++ (re.opt (re.range "-" "-")) ((_ re.loop 11 11) (re.range "0" "9"))))(re.union (re.++ (re.union (str.to_re (str.++ "L" (str.++ "T" ""))) (str.to_re (str.++ "S" (str.++ "E" ""))))(re.++ (re.opt (re.range "-" "-")) ((_ re.loop 12 12) (re.range "0" "9"))))(re.union (re.++ (str.to_re (str.++ "A" (str.++ "T" "")))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.range "U" "U") ((_ re.loop 8 8) (re.range "0" "9")))))(re.union (re.++ (str.to_re (str.++ "C" (str.++ "Y" "")))(re.++ (re.opt (re.range "-" "-"))(re.++ ((_ re.loop 8 8) (re.range "0" "9")) (re.range "A" "Z"))))(re.union (re.++ (str.to_re (str.++ "C" (str.++ "Z" "")))(re.++ (re.opt (re.range "-" "-")) ((_ re.loop 8 10) (re.range "0" "9"))))(re.union (re.++ (str.to_re (str.++ "F" (str.++ "R" "")))(re.++ (re.opt (re.range "-" "-"))(re.++ ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "H")(re.union (re.range "J" "N") (re.range "P" "Z"))))) ((_ re.loop 9 9) (re.range "0" "9")))))(re.union (re.++ (str.to_re (str.++ "I" (str.++ "E" "")))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.range "0" "9")(re.++ (re.union (re.range "0" "9") (re.range "A" "Z"))(re.++ ((_ re.loop 5 5) (re.range "0" "9")) (re.range "A" "Z"))))))(re.union (re.++ (str.to_re (str.++ "N" (str.++ "L" "")))(re.++ (re.opt (re.range "-" "-"))(re.++ ((_ re.loop 9 9) (re.range "0" "9"))(re.++ (re.range "B" "B") ((_ re.loop 2 2) (re.range "0" "9")))))) (re.++ (str.to_re (str.++ "E" (str.++ "S" "")))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.union (re.range "0" "9") (re.range "A" "Z"))(re.++ ((_ re.loop 7 7) (re.range "0" "9")) (re.union (re.range "0" "9") (re.range "A" "Z")))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
