;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = &quot;([^&quot;](?:\\.|[^\\&quot;]*)*)&quot;
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00F0&quot;]&quot;"
(define-fun Witness1 () String (seq.++ "\xf0" (seq.++ "&" (seq.++ "q" (seq.++ "u" (seq.++ "o" (seq.++ "t" (seq.++ ";" (seq.++ "]" (seq.++ "&" (seq.++ "q" (seq.++ "u" (seq.++ "o" (seq.++ "t" (seq.++ ";" "")))))))))))))))
;witness2: "\u00B4\u0084&quot;w\\u008D&quot;\u00D9"
(define-fun Witness2 () String (seq.++ "\xb4" (seq.++ "\x84" (seq.++ "&" (seq.++ "q" (seq.++ "u" (seq.++ "o" (seq.++ "t" (seq.++ ";" (seq.++ "w" (seq.++ "\x5c" (seq.++ "\x8d" (seq.++ "&" (seq.++ "q" (seq.++ "u" (seq.++ "o" (seq.++ "t" (seq.++ ";" (seq.++ "\xd9" "")))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "&" (seq.++ "q" (seq.++ "u" (seq.++ "o" (seq.++ "t" (seq.++ ";" "")))))))(re.++ (re.++ (re.union (re.range "\x00" "%")(re.union (re.range "'" ":")(re.union (re.range "<" "n")(re.union (re.range "p" "p")(re.union (re.range "r" "s") (re.range "v" "\xff")))))) (re.* (re.union (re.++ (re.range "\x5c" "\x5c") (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))) (re.* (re.union (re.range "\x00" "%")(re.union (re.range "'" ":")(re.union (re.range "<" "[")(re.union (re.range "]" "n")(re.union (re.range "p" "p")(re.union (re.range "r" "s") (re.range "v" "\xff"))))))))))) (str.to_re (seq.++ "&" (seq.++ "q" (seq.++ "u" (seq.++ "o" (seq.++ "t" (seq.++ ";" "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
