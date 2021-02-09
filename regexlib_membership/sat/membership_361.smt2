;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(\d{3,})\s?(\w{0,5})\s([a-zA-Z]{2,30})\s([a-zA-Z]{2,15})\.?\s?(\w{0,5})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "850\u00A0ouzx\u00A0YOzM"
(define-fun Witness1 () String (seq.++ "8" (seq.++ "5" (seq.++ "0" (seq.++ "\xa0" (seq.++ "o" (seq.++ "u" (seq.++ "z" (seq.++ "x" (seq.++ "\xa0" (seq.++ "Y" (seq.++ "O" (seq.++ "z" (seq.++ "M" ""))))))))))))))
;witness2: "984\xC8\u00E9 dz tZTw\xD"
(define-fun Witness2 () String (seq.++ "9" (seq.++ "8" (seq.++ "4" (seq.++ "\x0c" (seq.++ "8" (seq.++ "\xe9" (seq.++ " " (seq.++ "d" (seq.++ "z" (seq.++ " " (seq.++ "t" (seq.++ "Z" (seq.++ "T" (seq.++ "w" (seq.++ "\x0d" ""))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ ((_ re.loop 3 3) (re.range "0" "9")) (re.* (re.range "0" "9")))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ ((_ re.loop 0 5) (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))(re.++ ((_ re.loop 2 30) (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))(re.++ ((_ re.loop 2 15) (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.opt (re.range "." "."))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ ((_ re.loop 0 5) (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))) (str.to_re ""))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
