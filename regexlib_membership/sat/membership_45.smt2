;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ((\(\d{3}\) ?)|(\d{3}-))?\d{3}-\d{4}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\x0952-979-0884"
(define-fun Witness1 () String (seq.++ "\x00" (seq.++ "9" (seq.++ "5" (seq.++ "2" (seq.++ "-" (seq.++ "9" (seq.++ "7" (seq.++ "9" (seq.++ "-" (seq.++ "0" (seq.++ "8" (seq.++ "8" (seq.++ "4" ""))))))))))))))
;witness2: "999-255-4889\xD\u00BE:"
(define-fun Witness2 () String (seq.++ "9" (seq.++ "9" (seq.++ "9" (seq.++ "-" (seq.++ "2" (seq.++ "5" (seq.++ "5" (seq.++ "-" (seq.++ "4" (seq.++ "8" (seq.++ "8" (seq.++ "9" (seq.++ "\x0d" (seq.++ "\xbe" (seq.++ ":" ""))))))))))))))))

(assert (= regexA (re.++ (re.opt (re.union (re.++ (re.range "(" "(")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range ")" ")") (re.opt (re.range " " " "))))) (re.++ ((_ re.loop 3 3) (re.range "0" "9")) (re.range "-" "-"))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range "-" "-") ((_ re.loop 4 4) (re.range "0" "9")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
