;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?:[\w]*) *= *"(?:(?:(?:(?:(?:\\\W)*\\\W)*[^"]*)\\\W)*[^"]*")
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "]\u00C5=\"\@\:\@\@\%\\x4\\u00D7\@\$\".)\u00E7"
(define-fun Witness1 () String (seq.++ "]" (seq.++ "\xc5" (seq.++ "=" (seq.++ "\x22" (seq.++ "\x5c" (seq.++ "@" (seq.++ "\x5c" (seq.++ ":" (seq.++ "\x5c" (seq.++ "@" (seq.++ "\x5c" (seq.++ "@" (seq.++ "\x5c" (seq.++ "%" (seq.++ "\x5c" (seq.++ "\x04" (seq.++ "\x5c" (seq.++ "\xd7" (seq.++ "\x5c" (seq.++ "@" (seq.++ "\x5c" (seq.++ "$" (seq.++ "\x22" (seq.++ "." (seq.++ ")" (seq.++ "\xe7" "")))))))))))))))))))))))))))
;witness2: "8 =\"\\u00F7\u00AAX\=A^\\u00D7\\xD\\u00AB\\u00BB\`\\u00A5\\u00F7\\u00D7\\x3\\u00D7\\u0096\u00F5\u0093\\u00F77\"\x15\u00E6G"
(define-fun Witness2 () String (seq.++ "8" (seq.++ " " (seq.++ "=" (seq.++ "\x22" (seq.++ "\x5c" (seq.++ "\xf7" (seq.++ "\xaa" (seq.++ "X" (seq.++ "\x5c" (seq.++ "=" (seq.++ "A" (seq.++ "^" (seq.++ "\x5c" (seq.++ "\xd7" (seq.++ "\x5c" (seq.++ "\x0d" (seq.++ "\x5c" (seq.++ "\xab" (seq.++ "\x5c" (seq.++ "\xbb" (seq.++ "\x5c" (seq.++ "`" (seq.++ "\x5c" (seq.++ "\xa5" (seq.++ "\x5c" (seq.++ "\xf7" (seq.++ "\x5c" (seq.++ "\xd7" (seq.++ "\x5c" (seq.++ "\x03" (seq.++ "\x5c" (seq.++ "\xd7" (seq.++ "\x5c" (seq.++ "\x96" (seq.++ "\xf5" (seq.++ "\x93" (seq.++ "\x5c" (seq.++ "\xf7" (seq.++ "7" (seq.++ "\x22" (seq.++ "\x15" (seq.++ "\xe6" (seq.++ "G" ""))))))))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (re.* (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))(re.++ (re.* (re.range " " " "))(re.++ (re.range "=" "=")(re.++ (re.* (re.range " " " "))(re.++ (re.range "\x22" "\x22")(re.++ (re.* (re.++ (re.* (re.++ (re.* (re.++ (re.range "\x5c" "\x5c") (re.union (re.range "\x00" "/")(re.union (re.range ":" "@")(re.union (re.range "[" "^")(re.union (re.range "`" "`")(re.union (re.range "{" "\xa9")(re.union (re.range "\xab" "\xb4")(re.union (re.range "\xb6" "\xb9")(re.union (re.range "\xbb" "\xbf")(re.union (re.range "\xd7" "\xd7") (re.range "\xf7" "\xf7"))))))))))))(re.++ (re.range "\x5c" "\x5c") (re.union (re.range "\x00" "/")(re.union (re.range ":" "@")(re.union (re.range "[" "^")(re.union (re.range "`" "`")(re.union (re.range "{" "\xa9")(re.union (re.range "\xab" "\xb4")(re.union (re.range "\xb6" "\xb9")(re.union (re.range "\xbb" "\xbf")(re.union (re.range "\xd7" "\xd7") (re.range "\xf7" "\xf7")))))))))))))(re.++ (re.* (re.union (re.range "\x00" "!") (re.range "#" "\xff")))(re.++ (re.range "\x5c" "\x5c") (re.union (re.range "\x00" "/")(re.union (re.range ":" "@")(re.union (re.range "[" "^")(re.union (re.range "`" "`")(re.union (re.range "{" "\xa9")(re.union (re.range "\xab" "\xb4")(re.union (re.range "\xb6" "\xb9")(re.union (re.range "\xbb" "\xbf")(re.union (re.range "\xd7" "\xd7") (re.range "\xf7" "\xf7"))))))))))))))(re.++ (re.* (re.union (re.range "\x00" "!") (re.range "#" "\xff"))) (re.range "\x22" "\x22"))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
