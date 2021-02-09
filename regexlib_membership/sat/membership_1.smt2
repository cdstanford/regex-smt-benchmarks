;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ([A-Za-z]{0,}[\.\,\s]{0,}[A-Za-z]{1,}[\.\s]{1,}[0-9]{1,2}[\,\s]{0,}[0-9]{4})| ([0-9]{0,4}[-,\s]{0,}[A-Za-z]{3,9}[-,\s]{0,}[0-9]{1,2}[-,\s]{0,}[A-Za-z]{0,8})| ([0-9]{1,4}[\/\.\-][0-9]{1,4}[\/\.\-][0-9]{1,4})
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "Lgt\u00A4Jd\u0085\u0085 B\xD\x9\u00A0934019"
(define-fun Witness1 () String (seq.++ "L" (seq.++ "g" (seq.++ "t" (seq.++ "\xa4" (seq.++ "J" (seq.++ "d" (seq.++ "\x85" (seq.++ "\x85" (seq.++ " " (seq.++ "B" (seq.++ "\x0d" (seq.++ "\x09" (seq.++ "\xa0" (seq.++ "9" (seq.++ "3" (seq.++ "4" (seq.++ "0" (seq.++ "1" (seq.++ "9" ""))))))))))))))))))))
;witness2: "\u00C7\u00C2\x4\x7qwqZ.938989\u0098"
(define-fun Witness2 () String (seq.++ "\xc7" (seq.++ "\xc2" (seq.++ "\x04" (seq.++ "\x07" (seq.++ "q" (seq.++ "w" (seq.++ "q" (seq.++ "Z" (seq.++ "." (seq.++ "9" (seq.++ "3" (seq.++ "8" (seq.++ "9" (seq.++ "8" (seq.++ "9" (seq.++ "\x98" "")))))))))))))))))

(assert (= regexA (re.union (re.++ (re.* (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "," ",")(re.union (re.range "." ".")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))))(re.++ (re.+ (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.+ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "." ".")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))(re.++ ((_ re.loop 1 2) (re.range "0" "9"))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "," ",")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))) ((_ re.loop 4 4) (re.range "0" "9"))))))))(re.union (re.++ (re.range " " " ") (re.++ ((_ re.loop 0 4) (re.range "0" "9"))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "," "-")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))(re.++ ((_ re.loop 3 9) (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "," "-")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))(re.++ ((_ re.loop 1 2) (re.range "0" "9"))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "," "-")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))) ((_ re.loop 0 8) (re.union (re.range "A" "Z") (re.range "a" "z")))))))))) (re.++ (re.range " " " ") (re.++ ((_ re.loop 1 4) (re.range "0" "9"))(re.++ (re.range "-" "/")(re.++ ((_ re.loop 1 4) (re.range "0" "9"))(re.++ (re.range "-" "/") ((_ re.loop 1 4) (re.range "0" "9")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
