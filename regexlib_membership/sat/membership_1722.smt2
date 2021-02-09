;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((([0]?[1-9]|1[0-2])(:|\.)(00|15|30|45)?( )?(AM|am|aM|Am|PM|pm|pM|Pm))|(([0]?[0-9]|1[0-9]|2[0-3])(:|\.)(00|15|30|45)?))$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "05.15"
(define-fun Witness1 () String (seq.++ "0" (seq.++ "5" (seq.++ "." (seq.++ "1" (seq.++ "5" ""))))))
;witness2: "9:15"
(define-fun Witness2 () String (seq.++ "9" (seq.++ ":" (seq.++ "1" (seq.++ "5" "")))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.union (re.++ (re.opt (re.range "0" "0")) (re.range "1" "9")) (re.++ (re.range "1" "1") (re.range "0" "2")))(re.++ (re.union (re.range "." ".") (re.range ":" ":"))(re.++ (re.opt (re.union (str.to_re (seq.++ "0" (seq.++ "0" "")))(re.union (str.to_re (seq.++ "1" (seq.++ "5" "")))(re.union (str.to_re (seq.++ "3" (seq.++ "0" ""))) (str.to_re (seq.++ "4" (seq.++ "5" "")))))))(re.++ (re.opt (re.range " " " ")) (re.union (str.to_re (seq.++ "A" (seq.++ "M" "")))(re.union (str.to_re (seq.++ "a" (seq.++ "m" "")))(re.union (str.to_re (seq.++ "a" (seq.++ "M" "")))(re.union (str.to_re (seq.++ "A" (seq.++ "m" "")))(re.union (str.to_re (seq.++ "P" (seq.++ "M" "")))(re.union (str.to_re (seq.++ "p" (seq.++ "m" "")))(re.union (str.to_re (seq.++ "p" (seq.++ "M" ""))) (str.to_re (seq.++ "P" (seq.++ "m" "")))))))))))))) (re.++ (re.union (re.++ (re.opt (re.range "0" "0")) (re.range "0" "9"))(re.union (re.++ (re.range "1" "1") (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "3"))))(re.++ (re.union (re.range "." ".") (re.range ":" ":")) (re.opt (re.union (str.to_re (seq.++ "0" (seq.++ "0" "")))(re.union (str.to_re (seq.++ "1" (seq.++ "5" "")))(re.union (str.to_re (seq.++ "3" (seq.++ "0" ""))) (str.to_re (seq.++ "4" (seq.++ "5" "")))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
