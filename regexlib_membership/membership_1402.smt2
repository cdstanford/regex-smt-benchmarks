;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (0?[1-9]|[12][0-9]|3[01])[/ -](0?[1-9]|1[12])[/ -](19[0-9]{2}|[2][0-9][0-9]{2})
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "12 12/2396/T{"
(define-fun Witness1 () String (str.++ "1" (str.++ "2" (str.++ " " (str.++ "1" (str.++ "2" (str.++ "/" (str.++ "2" (str.++ "3" (str.++ "9" (str.++ "6" (str.++ "/" (str.++ "T" (str.++ "{" ""))))))))))))))
;witness2: "31 11-2173"
(define-fun Witness2 () String (str.++ "3" (str.++ "1" (str.++ " " (str.++ "1" (str.++ "1" (str.++ "-" (str.++ "2" (str.++ "1" (str.++ "7" (str.++ "3" "")))))))))))

(assert (= regexA (re.++ (re.union (re.++ (re.opt (re.range "0" "0")) (re.range "1" "9"))(re.union (re.++ (re.range "1" "2") (re.range "0" "9")) (re.++ (re.range "3" "3") (re.range "0" "1"))))(re.++ (re.union (re.range " " " ")(re.union (re.range "-" "-") (re.range "/" "/")))(re.++ (re.union (re.++ (re.opt (re.range "0" "0")) (re.range "1" "9")) (re.++ (re.range "1" "1") (re.range "1" "2")))(re.++ (re.union (re.range " " " ")(re.union (re.range "-" "-") (re.range "/" "/"))) (re.union (re.++ (str.to_re (str.++ "1" (str.++ "9" ""))) ((_ re.loop 2 2) (re.range "0" "9"))) (re.++ (re.range "2" "2")(re.++ (re.range "0" "9") ((_ re.loop 2 2) (re.range "0" "9")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
