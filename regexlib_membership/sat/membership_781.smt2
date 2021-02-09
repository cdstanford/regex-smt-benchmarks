;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (((\d{0,2})\(\d{3}\))|(\d{3}-))\d{3}-\d{4}\s{0,}((([Ee][xX][Tt])|([Pp][Oo][Ss][Tt][Ee])):\d{1,5}){0,1}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "R\xC291-748-8590eXT:1#I\x1A\u0090cRV"
(define-fun Witness1 () String (seq.++ "R" (seq.++ "\x0c" (seq.++ "2" (seq.++ "9" (seq.++ "1" (seq.++ "-" (seq.++ "7" (seq.++ "4" (seq.++ "8" (seq.++ "-" (seq.++ "8" (seq.++ "5" (seq.++ "9" (seq.++ "0" (seq.++ "e" (seq.++ "X" (seq.++ "T" (seq.++ ":" (seq.++ "1" (seq.++ "#" (seq.++ "I" (seq.++ "\x1a" (seq.++ "\x90" (seq.++ "c" (seq.++ "R" (seq.++ "V" "")))))))))))))))))))))))))))
;witness2: "380-680-8399\u0085\u00F2"
(define-fun Witness2 () String (seq.++ "3" (seq.++ "8" (seq.++ "0" (seq.++ "-" (seq.++ "6" (seq.++ "8" (seq.++ "0" (seq.++ "-" (seq.++ "8" (seq.++ "3" (seq.++ "9" (seq.++ "9" (seq.++ "\x85" (seq.++ "\xf2" "")))))))))))))))

(assert (= regexA (re.++ (re.union (re.++ ((_ re.loop 0 2) (re.range "0" "9"))(re.++ (re.range "(" "(")(re.++ ((_ re.loop 3 3) (re.range "0" "9")) (re.range ")" ")")))) (re.++ ((_ re.loop 3 3) (re.range "0" "9")) (re.range "-" "-")))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (re.opt (re.++ (re.union (re.++ (re.union (re.range "E" "E") (re.range "e" "e"))(re.++ (re.union (re.range "X" "X") (re.range "x" "x")) (re.union (re.range "T" "T") (re.range "t" "t")))) (re.++ (re.union (re.range "P" "P") (re.range "p" "p"))(re.++ (re.union (re.range "O" "O") (re.range "o" "o"))(re.++ (re.union (re.range "S" "S") (re.range "s" "s"))(re.++ (re.union (re.range "T" "T") (re.range "t" "t")) (re.union (re.range "E" "E") (re.range "e" "e")))))))(re.++ (re.range ":" ":") ((_ re.loop 1 5) (re.range "0" "9"))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
