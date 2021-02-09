;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?:[0-9]{4}-){3}[0-9]{4}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\x1A5997-9398-9890-9486\u009A$\u00BDK\u00A9\u00A3"
(define-fun Witness1 () String (seq.++ "\x1a" (seq.++ "5" (seq.++ "9" (seq.++ "9" (seq.++ "7" (seq.++ "-" (seq.++ "9" (seq.++ "3" (seq.++ "9" (seq.++ "8" (seq.++ "-" (seq.++ "9" (seq.++ "8" (seq.++ "9" (seq.++ "0" (seq.++ "-" (seq.++ "9" (seq.++ "4" (seq.++ "8" (seq.++ "6" (seq.++ "\x9a" (seq.++ "$" (seq.++ "\xbd" (seq.++ "K" (seq.++ "\xa9" (seq.++ "\xa3" "")))))))))))))))))))))))))))
;witness2: "\u00DF2826-7842-9748-0188"
(define-fun Witness2 () String (seq.++ "\xdf" (seq.++ "2" (seq.++ "8" (seq.++ "2" (seq.++ "6" (seq.++ "-" (seq.++ "7" (seq.++ "8" (seq.++ "4" (seq.++ "2" (seq.++ "-" (seq.++ "9" (seq.++ "7" (seq.++ "4" (seq.++ "8" (seq.++ "-" (seq.++ "0" (seq.++ "1" (seq.++ "8" (seq.++ "8" "")))))))))))))))))))))

(assert (= regexA (re.++ ((_ re.loop 3 3) (re.++ ((_ re.loop 4 4) (re.range "0" "9")) (re.range "-" "-"))) ((_ re.loop 4 4) (re.range "0" "9")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
