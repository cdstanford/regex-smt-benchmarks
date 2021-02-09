;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([0]\d|[1][0-2])\/([0-2]\d|[3][0-1])\/([2][01]|[1][6-9])\d{2}(\s([0]\d|[1][0-2])(\:[0-5]\d){1,2})*\s*([aApP][mM]{0,2})?$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "04/31/2199\u00A0 \u0085P"
(define-fun Witness1 () String (seq.++ "0" (seq.++ "4" (seq.++ "/" (seq.++ "3" (seq.++ "1" (seq.++ "/" (seq.++ "2" (seq.++ "1" (seq.++ "9" (seq.++ "9" (seq.++ "\xa0" (seq.++ " " (seq.++ "\x85" (seq.++ "P" "")))))))))))))))
;witness2: "12/21/1799"
(define-fun Witness2 () String (seq.++ "1" (seq.++ "2" (seq.++ "/" (seq.++ "2" (seq.++ "1" (seq.++ "/" (seq.++ "1" (seq.++ "7" (seq.++ "9" (seq.++ "9" "")))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.range "0" "0") (re.range "0" "9")) (re.++ (re.range "1" "1") (re.range "0" "2")))(re.++ (re.range "/" "/")(re.++ (re.union (re.++ (re.range "0" "2") (re.range "0" "9")) (re.++ (re.range "3" "3") (re.range "0" "1")))(re.++ (re.range "/" "/")(re.++ (re.union (re.++ (re.range "2" "2") (re.range "0" "1")) (re.++ (re.range "1" "1") (re.range "6" "9")))(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.* (re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))(re.++ (re.union (re.++ (re.range "0" "0") (re.range "0" "9")) (re.++ (re.range "1" "1") (re.range "0" "2"))) ((_ re.loop 1 2) (re.++ (re.range ":" ":")(re.++ (re.range "0" "5") (re.range "0" "9")))))))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.opt (re.++ (re.union (re.range "A" "A")(re.union (re.range "P" "P")(re.union (re.range "a" "a") (re.range "p" "p")))) ((_ re.loop 0 2) (re.union (re.range "M" "M") (re.range "m" "m"))))) (str.to_re "")))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
