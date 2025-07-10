;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((\(44\))( )?|(\(\+44\))( )?|(\+44)( )?|(44)( )?)?((0)|(\(0\)))?( )?(((1[0-9]{3})|(7[1-57-9][0-9]{2}))( )?([0-9]{3}[ -]?[0-9]{3})|(2[0-9]{2}( )?[0-9]{3}[ -]?[0-9]{4}))$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "0 2808375751"
(define-fun Witness1 () String (str.++ "0" (str.++ " " (str.++ "2" (str.++ "8" (str.++ "0" (str.++ "8" (str.++ "3" (str.++ "7" (str.++ "5" (str.++ "7" (str.++ "5" (str.++ "1" "")))))))))))))
;witness2: "(+44)0 209299 9484"
(define-fun Witness2 () String (str.++ "(" (str.++ "+" (str.++ "4" (str.++ "4" (str.++ ")" (str.++ "0" (str.++ " " (str.++ "2" (str.++ "0" (str.++ "9" (str.++ "2" (str.++ "9" (str.++ "9" (str.++ " " (str.++ "9" (str.++ "4" (str.++ "8" (str.++ "4" "")))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.union (re.++ (str.to_re (str.++ "(" (str.++ "4" (str.++ "4" (str.++ ")" ""))))) (re.opt (re.range " " " ")))(re.union (re.++ (str.to_re (str.++ "(" (str.++ "+" (str.++ "4" (str.++ "4" (str.++ ")" "")))))) (re.opt (re.range " " " ")))(re.union (re.++ (str.to_re (str.++ "+" (str.++ "4" (str.++ "4" "")))) (re.opt (re.range " " " "))) (re.++ (str.to_re (str.++ "4" (str.++ "4" ""))) (re.opt (re.range " " " ")))))))(re.++ (re.opt (re.union (re.range "0" "0") (str.to_re (str.++ "(" (str.++ "0" (str.++ ")" ""))))))(re.++ (re.opt (re.range " " " "))(re.++ (re.union (re.++ (re.union (re.++ (re.range "1" "1") ((_ re.loop 3 3) (re.range "0" "9"))) (re.++ (re.range "7" "7")(re.++ (re.union (re.range "1" "5") (re.range "7" "9")) ((_ re.loop 2 2) (re.range "0" "9")))))(re.++ (re.opt (re.range " " " ")) (re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range " " " ") (re.range "-" "-"))) ((_ re.loop 3 3) (re.range "0" "9")))))) (re.++ (re.range "2" "2")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.opt (re.range " " " "))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range " " " ") (re.range "-" "-"))) ((_ re.loop 4 4) (re.range "0" "9")))))))) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
