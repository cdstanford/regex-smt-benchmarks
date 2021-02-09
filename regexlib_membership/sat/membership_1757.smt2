;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = &lt;/?(\w+)(\s+\w+=(\w+|&quot;[^&quot;]*&quot;|'[^']*'))*&gt;
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "&lt;/\u00AAf\u00B5\u00AA\u00AA\u00B5&gt;e"
(define-fun Witness1 () String (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "/" (seq.++ "\xaa" (seq.++ "f" (seq.++ "\xb5" (seq.++ "\xaa" (seq.++ "\xaa" (seq.++ "\xb5" (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" (seq.++ "e" "")))))))))))))))))
;witness2: ";&lt;9&gt;zK\u00A1"
(define-fun Witness2 () String (seq.++ ";" (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" (seq.++ "9" (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" (seq.++ "z" (seq.++ "K" (seq.++ "\xa1" ""))))))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "&" (seq.++ "l" (seq.++ "t" (seq.++ ";" "")))))(re.++ (re.opt (re.range "/" "/"))(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))(re.++ (re.* (re.++ (re.+ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))(re.++ (re.range "=" "=") (re.union (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))(re.union (re.++ (str.to_re (seq.++ "&" (seq.++ "q" (seq.++ "u" (seq.++ "o" (seq.++ "t" (seq.++ ";" "")))))))(re.++ (re.* (re.union (re.range "\x00" "%")(re.union (re.range "'" ":")(re.union (re.range "<" "n")(re.union (re.range "p" "p")(re.union (re.range "r" "s") (re.range "v" "\xff"))))))) (str.to_re (seq.++ "&" (seq.++ "q" (seq.++ "u" (seq.++ "o" (seq.++ "t" (seq.++ ";" ""))))))))) (re.++ (re.range "'" "'")(re.++ (re.* (re.union (re.range "\x00" "&") (re.range "(" "\xff"))) (re.range "'" "'"))))))))) (str.to_re (seq.++ "&" (seq.++ "g" (seq.++ "t" (seq.++ ";" "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
