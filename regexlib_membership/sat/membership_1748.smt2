;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = <[a-zA-Z][^>]*\son\w+=(\w+|'[^']*'|"[^"]*")[^>]*>
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "<R\u00F9\u00A9\u00A0on\u00B5=\"\u00C5\">\x10"
(define-fun Witness1 () String (seq.++ "<" (seq.++ "R" (seq.++ "\xf9" (seq.++ "\xa9" (seq.++ "\xa0" (seq.++ "o" (seq.++ "n" (seq.++ "\xb5" (seq.++ "=" (seq.++ "\x22" (seq.++ "\xc5" (seq.++ "\x22" (seq.++ ">" (seq.++ "\x10" "")))))))))))))))
;witness2: "<h\u008F\u009B\x9onk=\"\">"
(define-fun Witness2 () String (seq.++ "<" (seq.++ "h" (seq.++ "\x8f" (seq.++ "\x9b" (seq.++ "\x09" (seq.++ "o" (seq.++ "n" (seq.++ "k" (seq.++ "=" (seq.++ "\x22" (seq.++ "\x22" (seq.++ ">" "")))))))))))))

(assert (= regexA (re.++ (re.range "<" "<")(re.++ (re.union (re.range "A" "Z") (re.range "a" "z"))(re.++ (re.* (re.union (re.range "\x00" "=") (re.range "?" "\xff")))(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))(re.++ (str.to_re (seq.++ "o" (seq.++ "n" "")))(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))(re.++ (re.range "=" "=")(re.++ (re.union (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))(re.union (re.++ (re.range "'" "'")(re.++ (re.* (re.union (re.range "\x00" "&") (re.range "(" "\xff"))) (re.range "'" "'"))) (re.++ (re.range "\x22" "\x22")(re.++ (re.* (re.union (re.range "\x00" "!") (re.range "#" "\xff"))) (re.range "\x22" "\x22")))))(re.++ (re.* (re.union (re.range "\x00" "=") (re.range "?" "\xff"))) (re.range ">" ">"))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
