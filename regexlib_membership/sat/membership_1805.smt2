;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((([0]?[1-9]|1[0-2])(:|\.)[0-5][0-9]((:|\.)[0-5][0-9])?( )?(AM|am|aM|Am|PM|pm|pM|Pm))|(([0]?[0-9]|1[0-9]|2[0-3])(:|\.)[0-5][0-9]((:|\.)[0-5][0-9])?))$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "01:47.38 Pm"
(define-fun Witness1 () String (str.++ "0" (str.++ "1" (str.++ ":" (str.++ "4" (str.++ "7" (str.++ "." (str.++ "3" (str.++ "8" (str.++ " " (str.++ "P" (str.++ "m" ""))))))))))))
;witness2: "20:25:01"
(define-fun Witness2 () String (str.++ "2" (str.++ "0" (str.++ ":" (str.++ "2" (str.++ "5" (str.++ ":" (str.++ "0" (str.++ "1" "")))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.union (re.++ (re.opt (re.range "0" "0")) (re.range "1" "9")) (re.++ (re.range "1" "1") (re.range "0" "2")))(re.++ (re.union (re.range "." ".") (re.range ":" ":"))(re.++ (re.range "0" "5")(re.++ (re.range "0" "9")(re.++ (re.opt (re.++ (re.union (re.range "." ".") (re.range ":" ":"))(re.++ (re.range "0" "5") (re.range "0" "9"))))(re.++ (re.opt (re.range " " " ")) (re.union (str.to_re (str.++ "A" (str.++ "M" "")))(re.union (str.to_re (str.++ "a" (str.++ "m" "")))(re.union (str.to_re (str.++ "a" (str.++ "M" "")))(re.union (str.to_re (str.++ "A" (str.++ "m" "")))(re.union (str.to_re (str.++ "P" (str.++ "M" "")))(re.union (str.to_re (str.++ "p" (str.++ "m" "")))(re.union (str.to_re (str.++ "p" (str.++ "M" ""))) (str.to_re (str.++ "P" (str.++ "m" "")))))))))))))))) (re.++ (re.union (re.++ (re.opt (re.range "0" "0")) (re.range "0" "9"))(re.union (re.++ (re.range "1" "1") (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "3"))))(re.++ (re.union (re.range "." ".") (re.range ":" ":"))(re.++ (re.range "0" "5")(re.++ (re.range "0" "9") (re.opt (re.++ (re.union (re.range "." ".") (re.range ":" ":"))(re.++ (re.range "0" "5") (re.range "0" "9"))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
