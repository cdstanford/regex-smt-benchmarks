;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = CH\d{2}[ ]\d{4}[ ]\d{4}[ ]\d{4}[ ]\d{4}[ ]\d{1}|CH\d{19}
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "CH70 9998 8980 5508 8846 0"
(define-fun Witness1 () String (str.++ "C" (str.++ "H" (str.++ "7" (str.++ "0" (str.++ " " (str.++ "9" (str.++ "9" (str.++ "9" (str.++ "8" (str.++ " " (str.++ "8" (str.++ "9" (str.++ "8" (str.++ "0" (str.++ " " (str.++ "5" (str.++ "5" (str.++ "0" (str.++ "8" (str.++ " " (str.++ "8" (str.++ "8" (str.++ "4" (str.++ "6" (str.++ " " (str.++ "0" "")))))))))))))))))))))))))))
;witness2: "CH49 4998 8048 0158 9391 7\u00F3\u00F0\u00B7"
(define-fun Witness2 () String (str.++ "C" (str.++ "H" (str.++ "4" (str.++ "9" (str.++ " " (str.++ "4" (str.++ "9" (str.++ "9" (str.++ "8" (str.++ " " (str.++ "8" (str.++ "0" (str.++ "4" (str.++ "8" (str.++ " " (str.++ "0" (str.++ "1" (str.++ "5" (str.++ "8" (str.++ " " (str.++ "9" (str.++ "3" (str.++ "9" (str.++ "1" (str.++ " " (str.++ "7" (str.++ "\u{f3}" (str.++ "\u{f0}" (str.++ "\u{b7}" ""))))))))))))))))))))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re (str.++ "C" (str.++ "H" "")))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ") (re.range "0" "9")))))))))))) (re.++ (str.to_re (str.++ "C" (str.++ "H" ""))) ((_ re.loop 19 19) (re.range "0" "9"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
