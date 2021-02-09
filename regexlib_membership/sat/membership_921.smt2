;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = <script.*/*>|</script>|<[a-zA-Z][^>]*=['"]+javascript:\w+.*['"]+>|<\w+[^>]*\son\w+=.*[ /]*>
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\x0<G=\"\"\"javascript:8\'>X\u009A"
(define-fun Witness1 () String (seq.++ "\x00" (seq.++ "<" (seq.++ "G" (seq.++ "=" (seq.++ "\x22" (seq.++ "\x22" (seq.++ "\x22" (seq.++ "j" (seq.++ "a" (seq.++ "v" (seq.++ "a" (seq.++ "s" (seq.++ "c" (seq.++ "r" (seq.++ "i" (seq.++ "p" (seq.++ "t" (seq.++ ":" (seq.++ "8" (seq.++ "'" (seq.++ ">" (seq.++ "X" (seq.++ "\x9a" ""))))))))))))))))))))))))
;witness2: "</script>\xF\u00DA"
(define-fun Witness2 () String (seq.++ "<" (seq.++ "/" (seq.++ "s" (seq.++ "c" (seq.++ "r" (seq.++ "i" (seq.++ "p" (seq.++ "t" (seq.++ ">" (seq.++ "\x0f" (seq.++ "\xda" ""))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re (seq.++ "<" (seq.++ "s" (seq.++ "c" (seq.++ "r" (seq.++ "i" (seq.++ "p" (seq.++ "t" ""))))))))(re.++ (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.++ (re.* (re.range "/" "/")) (re.range ">" ">"))))(re.union (str.to_re (seq.++ "<" (seq.++ "/" (seq.++ "s" (seq.++ "c" (seq.++ "r" (seq.++ "i" (seq.++ "p" (seq.++ "t" (seq.++ ">" ""))))))))))(re.union (re.++ (re.range "<" "<")(re.++ (re.union (re.range "A" "Z") (re.range "a" "z"))(re.++ (re.* (re.union (re.range "\x00" "=") (re.range "?" "\xff")))(re.++ (re.range "=" "=")(re.++ (re.+ (re.union (re.range "\x22" "\x22") (re.range "'" "'")))(re.++ (str.to_re (seq.++ "j" (seq.++ "a" (seq.++ "v" (seq.++ "a" (seq.++ "s" (seq.++ "c" (seq.++ "r" (seq.++ "i" (seq.++ "p" (seq.++ "t" (seq.++ ":" ""))))))))))))(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))(re.++ (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.++ (re.+ (re.union (re.range "\x22" "\x22") (re.range "'" "'"))) (re.range ">" ">")))))))))) (re.++ (re.range "<" "<")(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))(re.++ (re.* (re.union (re.range "\x00" "=") (re.range "?" "\xff")))(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))(re.++ (str.to_re (seq.++ "o" (seq.++ "n" "")))(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))(re.++ (re.range "=" "=")(re.++ (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.++ (re.* (re.union (re.range " " " ") (re.range "/" "/"))) (re.range ">" ">")))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
