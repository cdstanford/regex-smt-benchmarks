;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ((DK|FI|HU|LU|MT|SI)(-)?\d{8})|((BE|EE|DE|EL|LT|PT)(-)?\d{9})|((PL|SK)(-)?\d{10})|((IT|LV)(-)?\d{11})|((LT|SE)(-)?\d{12})|(AT(-)?U\d{8})|(CY(-)?\d{8}[A-Z])|(CZ(-)?\d{8,10})|(FR(-)?[\dA-HJ-NP-Z]{2}\d{9})|(IE(-)?\d[A-Z\d]\d{5}[A-Z])|(NL(-)?\d{9}B\d{2})|(ES(-)?[A-Z\d]\d{7}[A-Z\d])
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\x13NL-999989474B68\u00B7"
(define-fun Witness1 () String (seq.++ "\x13" (seq.++ "N" (seq.++ "L" (seq.++ "-" (seq.++ "9" (seq.++ "9" (seq.++ "9" (seq.++ "9" (seq.++ "8" (seq.++ "9" (seq.++ "4" (seq.++ "7" (seq.++ "4" (seq.++ "B" (seq.++ "6" (seq.++ "8" (seq.++ "\xb7" ""))))))))))))))))))
;witness2: "7CZ-99868836\u00A1\x1DJ\u00CC\u0096"
(define-fun Witness2 () String (seq.++ "7" (seq.++ "C" (seq.++ "Z" (seq.++ "-" (seq.++ "9" (seq.++ "9" (seq.++ "8" (seq.++ "6" (seq.++ "8" (seq.++ "8" (seq.++ "3" (seq.++ "6" (seq.++ "\xa1" (seq.++ "\x1d" (seq.++ "J" (seq.++ "\xcc" (seq.++ "\x96" ""))))))))))))))))))

(assert (= regexA (re.union (re.++ (re.union (str.to_re (seq.++ "D" (seq.++ "K" "")))(re.union (str.to_re (seq.++ "F" (seq.++ "I" "")))(re.union (str.to_re (seq.++ "H" (seq.++ "U" "")))(re.union (str.to_re (seq.++ "L" (seq.++ "U" "")))(re.union (str.to_re (seq.++ "M" (seq.++ "T" ""))) (str.to_re (seq.++ "S" (seq.++ "I" ""))))))))(re.++ (re.opt (re.range "-" "-")) ((_ re.loop 8 8) (re.range "0" "9"))))(re.union (re.++ (re.union (str.to_re (seq.++ "B" (seq.++ "E" "")))(re.union (str.to_re (seq.++ "E" (seq.++ "E" "")))(re.union (str.to_re (seq.++ "D" (seq.++ "E" "")))(re.union (str.to_re (seq.++ "E" (seq.++ "L" "")))(re.union (str.to_re (seq.++ "L" (seq.++ "T" ""))) (str.to_re (seq.++ "P" (seq.++ "T" ""))))))))(re.++ (re.opt (re.range "-" "-")) ((_ re.loop 9 9) (re.range "0" "9"))))(re.union (re.++ (re.union (str.to_re (seq.++ "P" (seq.++ "L" ""))) (str.to_re (seq.++ "S" (seq.++ "K" ""))))(re.++ (re.opt (re.range "-" "-")) ((_ re.loop 10 10) (re.range "0" "9"))))(re.union (re.++ (re.union (str.to_re (seq.++ "I" (seq.++ "T" ""))) (str.to_re (seq.++ "L" (seq.++ "V" ""))))(re.++ (re.opt (re.range "-" "-")) ((_ re.loop 11 11) (re.range "0" "9"))))(re.union (re.++ (re.union (str.to_re (seq.++ "L" (seq.++ "T" ""))) (str.to_re (seq.++ "S" (seq.++ "E" ""))))(re.++ (re.opt (re.range "-" "-")) ((_ re.loop 12 12) (re.range "0" "9"))))(re.union (re.++ (str.to_re (seq.++ "A" (seq.++ "T" "")))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.range "U" "U") ((_ re.loop 8 8) (re.range "0" "9")))))(re.union (re.++ (str.to_re (seq.++ "C" (seq.++ "Y" "")))(re.++ (re.opt (re.range "-" "-"))(re.++ ((_ re.loop 8 8) (re.range "0" "9")) (re.range "A" "Z"))))(re.union (re.++ (str.to_re (seq.++ "C" (seq.++ "Z" "")))(re.++ (re.opt (re.range "-" "-")) ((_ re.loop 8 10) (re.range "0" "9"))))(re.union (re.++ (str.to_re (seq.++ "F" (seq.++ "R" "")))(re.++ (re.opt (re.range "-" "-"))(re.++ ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "H")(re.union (re.range "J" "N") (re.range "P" "Z"))))) ((_ re.loop 9 9) (re.range "0" "9")))))(re.union (re.++ (str.to_re (seq.++ "I" (seq.++ "E" "")))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.range "0" "9")(re.++ (re.union (re.range "0" "9") (re.range "A" "Z"))(re.++ ((_ re.loop 5 5) (re.range "0" "9")) (re.range "A" "Z"))))))(re.union (re.++ (str.to_re (seq.++ "N" (seq.++ "L" "")))(re.++ (re.opt (re.range "-" "-"))(re.++ ((_ re.loop 9 9) (re.range "0" "9"))(re.++ (re.range "B" "B") ((_ re.loop 2 2) (re.range "0" "9")))))) (re.++ (str.to_re (seq.++ "E" (seq.++ "S" "")))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.union (re.range "0" "9") (re.range "A" "Z"))(re.++ ((_ re.loop 7 7) (re.range "0" "9")) (re.union (re.range "0" "9") (re.range "A" "Z")))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
