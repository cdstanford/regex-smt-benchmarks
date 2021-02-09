;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (".+"\s)?<?[a-z\._0-9]+[^\._]@([a-z0-9]+\.)+[a-z0-9]{2,6}>?;?
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\"\u00AD\" .\xD@u3q.8x>;"
(define-fun Witness1 () String (seq.++ "\x22" (seq.++ "\xad" (seq.++ "\x22" (seq.++ " " (seq.++ "." (seq.++ "\x0d" (seq.++ "@" (seq.++ "u" (seq.++ "3" (seq.++ "q" (seq.++ "." (seq.++ "8" (seq.++ "x" (seq.++ ">" (seq.++ ";" ""))))))))))))))))
;witness2: "54\u00E9@k.a01\u00EA"
(define-fun Witness2 () String (seq.++ "5" (seq.++ "4" (seq.++ "\xe9" (seq.++ "@" (seq.++ "k" (seq.++ "." (seq.++ "a" (seq.++ "0" (seq.++ "1" (seq.++ "\xea" "")))))))))))

(assert (= regexA (re.++ (re.opt (re.++ (re.range "\x22" "\x22")(re.++ (re.+ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.++ (re.range "\x22" "\x22") (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))))(re.++ (re.opt (re.range "<" "<"))(re.++ (re.+ (re.union (re.range "." ".")(re.union (re.range "0" "9")(re.union (re.range "_" "_") (re.range "a" "z")))))(re.++ (re.union (re.range "\x00" "-")(re.union (re.range "/" "^") (re.range "`" "\xff")))(re.++ (re.range "@" "@")(re.++ (re.+ (re.++ (re.+ (re.union (re.range "0" "9") (re.range "a" "z"))) (re.range "." ".")))(re.++ ((_ re.loop 2 6) (re.union (re.range "0" "9") (re.range "a" "z")))(re.++ (re.opt (re.range ">" ">")) (re.opt (re.range ";" ";"))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
