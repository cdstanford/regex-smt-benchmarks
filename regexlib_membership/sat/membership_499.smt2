;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (\+1 )?\d{3} \d{3} \d{4} 
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u0083\x10+1 607 889 0389 \u00DBp"
(define-fun Witness1 () String (seq.++ "\x83" (seq.++ "\x10" (seq.++ "+" (seq.++ "1" (seq.++ " " (seq.++ "6" (seq.++ "0" (seq.++ "7" (seq.++ " " (seq.++ "8" (seq.++ "8" (seq.++ "9" (seq.++ " " (seq.++ "0" (seq.++ "3" (seq.++ "8" (seq.++ "9" (seq.++ " " (seq.++ "\xdb" (seq.++ "p" "")))))))))))))))))))))
;witness2: "\u00C2699 339 7255 (!\x8\u00E2"
(define-fun Witness2 () String (seq.++ "\xc2" (seq.++ "6" (seq.++ "9" (seq.++ "9" (seq.++ " " (seq.++ "3" (seq.++ "3" (seq.++ "9" (seq.++ " " (seq.++ "7" (seq.++ "2" (seq.++ "5" (seq.++ "5" (seq.++ " " (seq.++ "(" (seq.++ "!" (seq.++ "\x08" (seq.++ "\xe2" "")))))))))))))))))))

(assert (= regexA (re.++ (re.opt (str.to_re (seq.++ "+" (seq.++ "1" (seq.++ " " "")))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9")) (re.range " " " ")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
