;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ([0-9]{4})-([0-9]{1,2})-([0-9]{1,2})
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\xBi-4884-8-2"
(define-fun Witness1 () String (seq.++ "\x0b" (seq.++ "i" (seq.++ "-" (seq.++ "4" (seq.++ "8" (seq.++ "8" (seq.++ "4" (seq.++ "-" (seq.++ "8" (seq.++ "-" (seq.++ "2" ""))))))))))))
;witness2: "8689-88-3\xAv\""
(define-fun Witness2 () String (seq.++ "8" (seq.++ "6" (seq.++ "8" (seq.++ "9" (seq.++ "-" (seq.++ "8" (seq.++ "8" (seq.++ "-" (seq.++ "3" (seq.++ "\x0a" (seq.++ "v" (seq.++ "\x22" "")))))))))))))

(assert (= regexA (re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 1 2) (re.range "0" "9"))(re.++ (re.range "-" "-") ((_ re.loop 1 2) (re.range "0" "9"))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
