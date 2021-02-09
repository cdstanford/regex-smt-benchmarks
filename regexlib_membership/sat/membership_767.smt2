;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([a-z|A-Z]{1}[0-9]{3})[-]([0-9]{3})[-]([0-9]{2})[-]([0-9]{3})[-]([0-9]{1})
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "L897-171-99-289-9\u00BF\xB\u00C2"
(define-fun Witness1 () String (seq.++ "L" (seq.++ "8" (seq.++ "9" (seq.++ "7" (seq.++ "-" (seq.++ "1" (seq.++ "7" (seq.++ "1" (seq.++ "-" (seq.++ "9" (seq.++ "9" (seq.++ "-" (seq.++ "2" (seq.++ "8" (seq.++ "9" (seq.++ "-" (seq.++ "9" (seq.++ "\xbf" (seq.++ "\x0b" (seq.++ "\xc2" "")))))))))))))))))))))
;witness2: "J914-844-26-284-9"
(define-fun Witness2 () String (seq.++ "J" (seq.++ "9" (seq.++ "1" (seq.++ "4" (seq.++ "-" (seq.++ "8" (seq.++ "4" (seq.++ "4" (seq.++ "-" (seq.++ "2" (seq.++ "6" (seq.++ "-" (seq.++ "2" (seq.++ "8" (seq.++ "4" (seq.++ "-" (seq.++ "9" ""))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.union (re.range "A" "Z")(re.union (re.range "a" "z") (re.range "|" "|"))) ((_ re.loop 3 3) (re.range "0" "9")))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range "-" "-") (re.range "0" "9"))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
