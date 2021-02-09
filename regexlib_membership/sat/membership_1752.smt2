;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (\d*)'*-*(\d*)/*(\d*)&quot;
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "49\'\'\'\'--&quot;"
(define-fun Witness1 () String (seq.++ "4" (seq.++ "9" (seq.++ "'" (seq.++ "'" (seq.++ "'" (seq.++ "'" (seq.++ "-" (seq.++ "-" (seq.++ "&" (seq.++ "q" (seq.++ "u" (seq.++ "o" (seq.++ "t" (seq.++ ";" "")))))))))))))))
;witness2: "6780&quot;\u00FD"
(define-fun Witness2 () String (seq.++ "6" (seq.++ "7" (seq.++ "8" (seq.++ "0" (seq.++ "&" (seq.++ "q" (seq.++ "u" (seq.++ "o" (seq.++ "t" (seq.++ ";" (seq.++ "\xfd" ""))))))))))))

(assert (= regexA (re.++ (re.* (re.range "0" "9"))(re.++ (re.* (re.range "'" "'"))(re.++ (re.* (re.range "-" "-"))(re.++ (re.* (re.range "0" "9"))(re.++ (re.* (re.range "/" "/"))(re.++ (re.* (re.range "0" "9")) (str.to_re (seq.++ "&" (seq.++ "q" (seq.++ "u" (seq.++ "o" (seq.++ "t" (seq.++ ";" "")))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
