;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\s*(((\d*\.?\d*[0-9]+\d*)|([0-9]+\d*\.\d*) )\s*[xX]\s*){2}((\d*\.?\d*[0-9]+\d*)|([0-9]+\d*\.\d*))\s*$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "881.9 x\u0085\xC3853. x9 \xA"
(define-fun Witness1 () String (seq.++ "8" (seq.++ "8" (seq.++ "1" (seq.++ "." (seq.++ "9" (seq.++ " " (seq.++ "x" (seq.++ "\x85" (seq.++ "\x0c" (seq.++ "3" (seq.++ "8" (seq.++ "5" (seq.++ "3" (seq.++ "." (seq.++ " " (seq.++ "x" (seq.++ "9" (seq.++ " " (seq.++ "\x0a" ""))))))))))))))))))))
;witness2: "67988X\u00A0\u00A07. x00098"
(define-fun Witness2 () String (seq.++ "6" (seq.++ "7" (seq.++ "9" (seq.++ "8" (seq.++ "8" (seq.++ "X" (seq.++ "\xa0" (seq.++ "\xa0" (seq.++ "7" (seq.++ "." (seq.++ " " (seq.++ "x" (seq.++ "0" (seq.++ "0" (seq.++ "0" (seq.++ "9" (seq.++ "8" ""))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ ((_ re.loop 2 2) (re.++ (re.union (re.++ (re.* (re.range "0" "9"))(re.++ (re.opt (re.range "." "."))(re.++ (re.* (re.range "0" "9"))(re.++ (re.+ (re.range "0" "9")) (re.* (re.range "0" "9")))))) (re.++ (re.++ (re.+ (re.range "0" "9"))(re.++ (re.* (re.range "0" "9"))(re.++ (re.range "." ".") (re.* (re.range "0" "9"))))) (re.range " " " ")))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.union (re.range "X" "X") (re.range "x" "x")) (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))))))(re.++ (re.union (re.++ (re.* (re.range "0" "9"))(re.++ (re.opt (re.range "." "."))(re.++ (re.* (re.range "0" "9"))(re.++ (re.+ (re.range "0" "9")) (re.* (re.range "0" "9")))))) (re.++ (re.+ (re.range "0" "9"))(re.++ (re.* (re.range "0" "9"))(re.++ (re.range "." ".") (re.* (re.range "0" "9"))))))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
