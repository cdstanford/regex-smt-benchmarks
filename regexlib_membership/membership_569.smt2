;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\s*-?(\d{0,7}|10[0-5]\d{0,5}|106[0-6]\d{0,4}|1067[0-4]\d{0,3}|10675[0-1]\d{0,2}|((\d{0,7}|10[0-5]\d{0,5}|106[0-6]\d{0,4}|1067[0-4]\d{0,3}|10675[0-1]\d{0,2})\.)?([0-1]?[0-9]|2[0-3]):[0-5]?[0-9](:[0-5]?[0-9](\.\d{1,7})?)?)\s*$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00A0-.10:6:56.9\u0085"
(define-fun Witness1 () String (str.++ "\u{a0}" (str.++ "-" (str.++ "." (str.++ "1" (str.++ "0" (str.++ ":" (str.++ "6" (str.++ ":" (str.++ "5" (str.++ "6" (str.++ "." (str.++ "9" (str.++ "\u{85}" ""))))))))))))))
;witness2: "\xA\u00A0-106750.23:8"
(define-fun Witness2 () String (str.++ "\u{0a}" (str.++ "\u{a0}" (str.++ "-" (str.++ "1" (str.++ "0" (str.++ "6" (str.++ "7" (str.++ "5" (str.++ "0" (str.++ "." (str.++ "2" (str.++ "3" (str.++ ":" (str.++ "8" "")))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.union ((_ re.loop 0 7) (re.range "0" "9"))(re.union (re.++ (str.to_re (str.++ "1" (str.++ "0" "")))(re.++ (re.range "0" "5") ((_ re.loop 0 5) (re.range "0" "9"))))(re.union (re.++ (str.to_re (str.++ "1" (str.++ "0" (str.++ "6" ""))))(re.++ (re.range "0" "6") ((_ re.loop 0 4) (re.range "0" "9"))))(re.union (re.++ (str.to_re (str.++ "1" (str.++ "0" (str.++ "6" (str.++ "7" "")))))(re.++ (re.range "0" "4") ((_ re.loop 0 3) (re.range "0" "9"))))(re.union (re.++ (str.to_re (str.++ "1" (str.++ "0" (str.++ "6" (str.++ "7" (str.++ "5" ""))))))(re.++ (re.range "0" "1") ((_ re.loop 0 2) (re.range "0" "9")))) (re.++ (re.opt (re.++ (re.union ((_ re.loop 0 7) (re.range "0" "9"))(re.union (re.++ (str.to_re (str.++ "1" (str.++ "0" "")))(re.++ (re.range "0" "5") ((_ re.loop 0 5) (re.range "0" "9"))))(re.union (re.++ (str.to_re (str.++ "1" (str.++ "0" (str.++ "6" ""))))(re.++ (re.range "0" "6") ((_ re.loop 0 4) (re.range "0" "9"))))(re.union (re.++ (str.to_re (str.++ "1" (str.++ "0" (str.++ "6" (str.++ "7" "")))))(re.++ (re.range "0" "4") ((_ re.loop 0 3) (re.range "0" "9")))) (re.++ (str.to_re (str.++ "1" (str.++ "0" (str.++ "6" (str.++ "7" (str.++ "5" ""))))))(re.++ (re.range "0" "1") ((_ re.loop 0 2) (re.range "0" "9")))))))) (re.range "." ".")))(re.++ (re.union (re.++ (re.opt (re.range "0" "1")) (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "3")))(re.++ (re.range ":" ":")(re.++ (re.opt (re.range "0" "5"))(re.++ (re.range "0" "9") (re.opt (re.++ (re.range ":" ":")(re.++ (re.opt (re.range "0" "5"))(re.++ (re.range "0" "9") (re.opt (re.++ (re.range "." ".") ((_ re.loop 1 7) (re.range "0" "9"))))))))))))))))))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
