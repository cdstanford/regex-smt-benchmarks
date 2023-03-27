;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (\+1 )?\d{3} \d{3} \d{4} 
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u0083\x10+1 607 889 0389 \u00DBp"
(define-fun Witness1 () String (str.++ "\u{83}" (str.++ "\u{10}" (str.++ "+" (str.++ "1" (str.++ " " (str.++ "6" (str.++ "0" (str.++ "7" (str.++ " " (str.++ "8" (str.++ "8" (str.++ "9" (str.++ " " (str.++ "0" (str.++ "3" (str.++ "8" (str.++ "9" (str.++ " " (str.++ "\u{db}" (str.++ "p" "")))))))))))))))))))))
;witness2: "\u00C2699 339 7255 (!\x8\u00E2"
(define-fun Witness2 () String (str.++ "\u{c2}" (str.++ "6" (str.++ "9" (str.++ "9" (str.++ " " (str.++ "3" (str.++ "3" (str.++ "9" (str.++ " " (str.++ "7" (str.++ "2" (str.++ "5" (str.++ "5" (str.++ " " (str.++ "(" (str.++ "!" (str.++ "\u{08}" (str.++ "\u{e2}" "")))))))))))))))))))

(assert (= regexA (re.++ (re.opt (str.to_re (str.++ "+" (str.++ "1" (str.++ " " "")))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9")) (re.range " " " ")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
