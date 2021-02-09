;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = .*[\$Ss]pecia[l1]\W[Oo0]ffer.*
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "$pecial;0ffer"
(define-fun Witness1 () String (seq.++ "$" (seq.++ "p" (seq.++ "e" (seq.++ "c" (seq.++ "i" (seq.++ "a" (seq.++ "l" (seq.++ ";" (seq.++ "0" (seq.++ "f" (seq.++ "f" (seq.++ "e" (seq.++ "r" ""))))))))))))))
;witness2: "Specia1=0ffer_"
(define-fun Witness2 () String (seq.++ "S" (seq.++ "p" (seq.++ "e" (seq.++ "c" (seq.++ "i" (seq.++ "a" (seq.++ "1" (seq.++ "=" (seq.++ "0" (seq.++ "f" (seq.++ "f" (seq.++ "e" (seq.++ "r" (seq.++ "_" "")))))))))))))))

(assert (= regexA (re.++ (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.++ (re.union (re.range "$" "$")(re.union (re.range "S" "S") (re.range "s" "s")))(re.++ (str.to_re (seq.++ "p" (seq.++ "e" (seq.++ "c" (seq.++ "i" (seq.++ "a" ""))))))(re.++ (re.union (re.range "1" "1") (re.range "l" "l"))(re.++ (re.union (re.range "\x00" "/")(re.union (re.range ":" "@")(re.union (re.range "[" "^")(re.union (re.range "`" "`")(re.union (re.range "{" "\xa9")(re.union (re.range "\xab" "\xb4")(re.union (re.range "\xb6" "\xb9")(re.union (re.range "\xbb" "\xbf")(re.union (re.range "\xd7" "\xd7") (re.range "\xf7" "\xf7"))))))))))(re.++ (re.union (re.range "0" "0")(re.union (re.range "O" "O") (re.range "o" "o")))(re.++ (str.to_re (seq.++ "f" (seq.++ "f" (seq.++ "e" (seq.++ "r" ""))))) (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
