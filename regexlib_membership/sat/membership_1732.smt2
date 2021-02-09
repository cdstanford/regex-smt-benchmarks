;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \({1}[0-9]{3}\){1}\-{1}[0-9]{3}\-{1}[0-9]{4}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "(878)-558-9188\u00EA\u00D5"
(define-fun Witness1 () String (seq.++ "(" (seq.++ "8" (seq.++ "7" (seq.++ "8" (seq.++ ")" (seq.++ "-" (seq.++ "5" (seq.++ "5" (seq.++ "8" (seq.++ "-" (seq.++ "9" (seq.++ "1" (seq.++ "8" (seq.++ "8" (seq.++ "\xea" (seq.++ "\xd5" "")))))))))))))))))
;witness2: "m(282)-263-4312\x1D["
(define-fun Witness2 () String (seq.++ "m" (seq.++ "(" (seq.++ "2" (seq.++ "8" (seq.++ "2" (seq.++ ")" (seq.++ "-" (seq.++ "2" (seq.++ "6" (seq.++ "3" (seq.++ "-" (seq.++ "4" (seq.++ "3" (seq.++ "1" (seq.++ "2" (seq.++ "\x1d" (seq.++ "[" ""))))))))))))))))))

(assert (= regexA (re.++ (re.range "(" "(")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (str.to_re (seq.++ ")" (seq.++ "-" "")))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range "-" "-") ((_ re.loop 4 4) (re.range "0" "9")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
