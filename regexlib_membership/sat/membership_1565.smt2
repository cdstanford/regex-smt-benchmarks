;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?<Telephone>([0-9]|[ ]|[-]|[\(]|[\)]|ext.|[,])+)([ ]|[:]|\t|[-])*(?<Where>Home|Office|Work|Away|Fax|FAX|Phone)|(?<Where>Home|Office|Work|Away|Fax|FAX|Phone|Daytime|Evening)([ ]|[:]|\t|[-])*(?<Telephone>([0-9]|[ ]|[-]|[\(]|[\)]|ext.|[,])+)|(?<Telephone>([(]([0-9]){3}[)]([ ])?([0-9]){3}([ ]|-)([0-9]){4}))
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "Eveningext\u00B8extVext\x1ext\u00A8extR\u0095t"
(define-fun Witness1 () String (seq.++ "E" (seq.++ "v" (seq.++ "e" (seq.++ "n" (seq.++ "i" (seq.++ "n" (seq.++ "g" (seq.++ "e" (seq.++ "x" (seq.++ "t" (seq.++ "\xb8" (seq.++ "e" (seq.++ "x" (seq.++ "t" (seq.++ "V" (seq.++ "e" (seq.++ "x" (seq.++ "t" (seq.++ "\x01" (seq.++ "e" (seq.++ "x" (seq.++ "t" (seq.++ "\xa8" (seq.++ "e" (seq.++ "x" (seq.++ "t" (seq.++ "R" (seq.++ "\x95" (seq.++ "t" ""))))))))))))))))))))))))))))))
;witness2: "82+\Fax:\x9ext\u00D366\u00DD\u00E0"
(define-fun Witness2 () String (seq.++ "8" (seq.++ "2" (seq.++ "+" (seq.++ "\x5c" (seq.++ "F" (seq.++ "a" (seq.++ "x" (seq.++ ":" (seq.++ "\x09" (seq.++ "e" (seq.++ "x" (seq.++ "t" (seq.++ "\xd3" (seq.++ "6" (seq.++ "6" (seq.++ "\xdd" (seq.++ "\xe0" ""))))))))))))))))))

(assert (= regexA (re.union (re.++ (re.+ (re.union (re.union (re.range " " " ")(re.union (re.range "(" ")")(re.union (re.range "-" "-") (re.range "0" "9"))))(re.union (re.++ (str.to_re (seq.++ "e" (seq.++ "x" (seq.++ "t" "")))) (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))) (re.range "," ","))))(re.++ (re.* (re.union (re.range "\x09" "\x09")(re.union (re.range " " " ")(re.union (re.range "-" "-") (re.range ":" ":"))))) (re.union (str.to_re (seq.++ "H" (seq.++ "o" (seq.++ "m" (seq.++ "e" "")))))(re.union (str.to_re (seq.++ "O" (seq.++ "f" (seq.++ "f" (seq.++ "i" (seq.++ "c" (seq.++ "e" "")))))))(re.union (str.to_re (seq.++ "W" (seq.++ "o" (seq.++ "r" (seq.++ "k" "")))))(re.union (str.to_re (seq.++ "A" (seq.++ "w" (seq.++ "a" (seq.++ "y" "")))))(re.union (str.to_re (seq.++ "F" (seq.++ "a" (seq.++ "x" ""))))(re.union (str.to_re (seq.++ "F" (seq.++ "A" (seq.++ "X" "")))) (str.to_re (seq.++ "P" (seq.++ "h" (seq.++ "o" (seq.++ "n" (seq.++ "e" ""))))))))))))))(re.union (re.++ (re.union (str.to_re (seq.++ "H" (seq.++ "o" (seq.++ "m" (seq.++ "e" "")))))(re.union (str.to_re (seq.++ "O" (seq.++ "f" (seq.++ "f" (seq.++ "i" (seq.++ "c" (seq.++ "e" "")))))))(re.union (str.to_re (seq.++ "W" (seq.++ "o" (seq.++ "r" (seq.++ "k" "")))))(re.union (str.to_re (seq.++ "A" (seq.++ "w" (seq.++ "a" (seq.++ "y" "")))))(re.union (str.to_re (seq.++ "F" (seq.++ "a" (seq.++ "x" ""))))(re.union (str.to_re (seq.++ "F" (seq.++ "A" (seq.++ "X" ""))))(re.union (str.to_re (seq.++ "P" (seq.++ "h" (seq.++ "o" (seq.++ "n" (seq.++ "e" ""))))))(re.union (str.to_re (seq.++ "D" (seq.++ "a" (seq.++ "y" (seq.++ "t" (seq.++ "i" (seq.++ "m" (seq.++ "e" "")))))))) (str.to_re (seq.++ "E" (seq.++ "v" (seq.++ "e" (seq.++ "n" (seq.++ "i" (seq.++ "n" (seq.++ "g" ""))))))))))))))))(re.++ (re.* (re.union (re.range "\x09" "\x09")(re.union (re.range " " " ")(re.union (re.range "-" "-") (re.range ":" ":"))))) (re.+ (re.union (re.union (re.range " " " ")(re.union (re.range "(" ")")(re.union (re.range "-" "-") (re.range "0" "9"))))(re.union (re.++ (str.to_re (seq.++ "e" (seq.++ "x" (seq.++ "t" "")))) (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))) (re.range "," ",")))))) (re.++ (re.range "(" "(")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range ")" ")")(re.++ (re.opt (re.range " " " "))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.union (re.range " " " ") (re.range "-" "-")) ((_ re.loop 4 4) (re.range "0" "9"))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
