;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = CH\d{2}[ ]\d{4}[ ]\d{4}[ ]\d{4}[ ]\d{4}[ ]\d{1}|CH\d{19}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "CH70 9998 8980 5508 8846 0"
(define-fun Witness1 () String (seq.++ "C" (seq.++ "H" (seq.++ "7" (seq.++ "0" (seq.++ " " (seq.++ "9" (seq.++ "9" (seq.++ "9" (seq.++ "8" (seq.++ " " (seq.++ "8" (seq.++ "9" (seq.++ "8" (seq.++ "0" (seq.++ " " (seq.++ "5" (seq.++ "5" (seq.++ "0" (seq.++ "8" (seq.++ " " (seq.++ "8" (seq.++ "8" (seq.++ "4" (seq.++ "6" (seq.++ " " (seq.++ "0" "")))))))))))))))))))))))))))
;witness2: "CH49 4998 8048 0158 9391 7\u00F3\u00F0\u00B7"
(define-fun Witness2 () String (seq.++ "C" (seq.++ "H" (seq.++ "4" (seq.++ "9" (seq.++ " " (seq.++ "4" (seq.++ "9" (seq.++ "9" (seq.++ "8" (seq.++ " " (seq.++ "8" (seq.++ "0" (seq.++ "4" (seq.++ "8" (seq.++ " " (seq.++ "0" (seq.++ "1" (seq.++ "5" (seq.++ "8" (seq.++ " " (seq.++ "9" (seq.++ "3" (seq.++ "9" (seq.++ "1" (seq.++ " " (seq.++ "7" (seq.++ "\xf3" (seq.++ "\xf0" (seq.++ "\xb7" ""))))))))))))))))))))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re (seq.++ "C" (seq.++ "H" "")))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ") (re.range "0" "9")))))))))))) (re.++ (str.to_re (seq.++ "C" (seq.++ "H" ""))) ((_ re.loop 19 19) (re.range "0" "9"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
