;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ((www|http)(\W+\S+[^).,:;?\]\} \r\n$]+))
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "http~Lc\u00EA3"
(define-fun Witness1 () String (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ "~" (seq.++ "L" (seq.++ "c" (seq.++ "\xea" (seq.++ "3" ""))))))))))
;witness2: "\x17www@\u0087\u00DC\u009E\u0080\x1A\u00BB\u00E4\x6\u00EF\u00EC\\u00DB\u00A9"
(define-fun Witness2 () String (seq.++ "\x17" (seq.++ "w" (seq.++ "w" (seq.++ "w" (seq.++ "@" (seq.++ "\x87" (seq.++ "\xdc" (seq.++ "\x9e" (seq.++ "\x80" (seq.++ "\x1a" (seq.++ "\xbb" (seq.++ "\xe4" (seq.++ "\x06" (seq.++ "\xef" (seq.++ "\xec" (seq.++ "\x5c" (seq.++ "\xdb" (seq.++ "\xa9" "")))))))))))))))))))

(assert (= regexA (re.++ (re.union (str.to_re (seq.++ "w" (seq.++ "w" (seq.++ "w" "")))) (str.to_re (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" "")))))) (re.++ (re.+ (re.union (re.range "\x00" "/")(re.union (re.range ":" "@")(re.union (re.range "[" "^")(re.union (re.range "`" "`")(re.union (re.range "{" "\xa9")(re.union (re.range "\xab" "\xb4")(re.union (re.range "\xb6" "\xb9")(re.union (re.range "\xbb" "\xbf")(re.union (re.range "\xd7" "\xd7") (re.range "\xf7" "\xf7")))))))))))(re.++ (re.+ (re.union (re.range "\x00" "\x08")(re.union (re.range "\x0e" "\x1f")(re.union (re.range "!" "\x84")(re.union (re.range "\x86" "\x9f") (re.range "\xa1" "\xff")))))) (re.+ (re.union (re.range "\x00" "\x09")(re.union (re.range "\x0b" "\x0c")(re.union (re.range "\x0e" "\x1f")(re.union (re.range "!" "#")(re.union (re.range "%" "(")(re.union (re.range "*" "+")(re.union (re.range "-" "-")(re.union (re.range "/" "9")(re.union (re.range "<" ">")(re.union (re.range "@" "\x5c")(re.union (re.range "^" "|") (re.range "~" "\xff"))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
