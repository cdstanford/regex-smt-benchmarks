;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(0[1-9]|1[012])[/](0[1-9]|[12][0-9]|3[01])[/][0-9]{4}(\s((0[1-9]|1[012])\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|]{2,2})))?$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "11/31/8086\u008512:23:59\xCPP"
(define-fun Witness1 () String (seq.++ "1" (seq.++ "1" (seq.++ "/" (seq.++ "3" (seq.++ "1" (seq.++ "/" (seq.++ "8" (seq.++ "0" (seq.++ "8" (seq.++ "6" (seq.++ "\x85" (seq.++ "1" (seq.++ "2" (seq.++ ":" (seq.++ "2" (seq.++ "3" (seq.++ ":" (seq.++ "5" (seq.++ "9" (seq.++ "\x0c" (seq.++ "P" (seq.++ "P" "")))))))))))))))))))))))
;witness2: "12/28/8418"
(define-fun Witness2 () String (seq.++ "1" (seq.++ "2" (seq.++ "/" (seq.++ "2" (seq.++ "8" (seq.++ "/" (seq.++ "8" (seq.++ "4" (seq.++ "1" (seq.++ "8" "")))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.range "0" "0") (re.range "1" "9")) (re.++ (re.range "1" "1") (re.range "0" "2")))(re.++ (re.range "/" "/")(re.++ (re.union (re.++ (re.range "0" "0") (re.range "1" "9"))(re.union (re.++ (re.range "1" "2") (re.range "0" "9")) (re.++ (re.range "3" "3") (re.range "0" "1"))))(re.++ (re.range "/" "/")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.opt (re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))) (re.++ (re.union (re.++ (re.range "0" "0") (re.range "1" "9")) (re.++ (re.range "1" "1") (re.range "0" "2")))(re.++ (re.range ":" ":")(re.++ (re.++ (re.range "0" "5") (re.range "0" "9"))(re.++ (re.union (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))) (re.++ (re.range ":" ":")(re.++ (re.++ (re.range "0" "5") (re.range "0" "9")) (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))) ((_ re.loop 2 2) (re.union (re.range "A" "A")(re.union (re.range "M" "M")(re.union (re.range "P" "P") (re.range "|" "|"))))))))))) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
