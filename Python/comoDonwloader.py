import tkinter as tk
from tkinter import ttk, filedialog
import paramiko
from paramiko import SSHException
from threading import Thread
import os
from ttkthemes import ThemedStyle

class SFTPDownloader:
    def __init__(self, master):
        self.master = master
        master.title("COMO Downloader")

        # SFTP Connection details
        self.host = tk.StringVar()
        self.port = tk.IntVar(value=22)
        self.username = tk.StringVar()
        self.password = tk.StringVar()
        self.server_path = tk.StringVar(value="/../../.../como/")
        self.download_path = tk.StringVar()

        # File details
        self.file_to_download = tk.StringVar()

        # Status variables
        self.server_status = tk.StringVar(value="Server: Not Checked")
        self.connection_status = tk.StringVar(value="Connection: Not Connected")
        self.download_status = tk.StringVar(value="Download Status: Idle")

        # Create widgets
        self.create_widgets()

    def create_widgets(self):
        style = ThemedStyle(self.master)
        style.set_theme("arc")

        # Connection Frame
        connection_frame = ttk.Frame(self.master, padding="20")
        connection_frame.grid(row=0, column=0, sticky=tk.W)

        ttk.Label(connection_frame, text="Host:").grid(row=0, column=0, sticky=tk.W, padx=(0, 10))
        ttk.Entry(connection_frame, textvariable=self.host, width=20).grid(row=0, column=1)

        ttk.Label(connection_frame, text="Port:").grid(row=0, column=2, sticky=tk.W, padx=(10, 10))
        ttk.Entry(connection_frame, textvariable=self.port, width=5).grid(row=0, column=3)

        ttk.Label(connection_frame, text="Username:").grid(row=1, column=0, sticky=tk.W, padx=(0, 10))
        ttk.Entry(connection_frame, textvariable=self.username, width=20).grid(row=1, column=1)

        ttk.Label(connection_frame, text="Password:").grid(row=1, column=2, sticky=tk.W, padx=(10, 10))
        ttk.Entry(connection_frame, textvariable=self.password, show="*", width=20).grid(row=1, column=3)

        ttk.Label(connection_frame, text="Server Path:").grid(row=2, column=0, sticky=tk.W, padx=(0, 10))
        ttk.Entry(connection_frame, textvariable=self.server_path, width=40).grid(row=2, column=1, columnspan=3)

        ttk.Button(connection_frame, text="Check Server", command=self.check_server).grid(row=3, column=1, pady=(10, 0))
        self.server_status_label = ttk.Label(connection_frame, textvariable=self.server_status, foreground="blue")
        self.server_status_label.grid(row=3, column=2, pady=(10, 0))

        ttk.Button(connection_frame, text="Connect", command=self.connect_sftp).grid(row=4, column=1, pady=(10, 0))
        ttk.Label(connection_frame, textvariable=self.connection_status, foreground="blue").grid(row=4, column=2, pady=(10, 0))

        # Download Frame
        download_frame = ttk.Frame(self.master, padding="20")
        download_frame.grid(row=1, column=0, sticky=tk.W)

        ttk.Label(download_frame, text="File to Download:").grid(row=0, column=0, sticky=tk.W, padx=(0, 10))
        ttk.Entry(download_frame, textvariable=self.file_to_download, width=20).grid(row=0, column=1)

        ttk.Label(download_frame, text="Local Download Path:").grid(row=1, column=0, sticky=tk.W, padx=(0, 10))
        ttk.Entry(download_frame, textvariable=self.download_path, width=30).grid(row=1, column=1)
        ttk.Button(download_frame, text="Browse", command=self.browse_download_path).grid(row=1, column=2)

        ttk.Button(download_frame, text="Download", command=self.download_file).grid(row=2, column=1, columnspan=2, pady=(10, 0))
        self.download_status_label = ttk.Label(download_frame, textvariable=self.download_status, foreground="blue")
        self.download_status_label.grid(row=3, column=0, columnspan=3, pady=(10, 0))

    def check_server(self):
        try:
            transport = paramiko.Transport((self.host.get(), self.port.get()))
            transport.connect()
            transport.close()
            self.server_status.set("Server: Available")
            self.server_status_label.configure(foreground="green")
        except Exception as e:
            self.server_status.set("Server: Unavailable")
            self.server_status_label.configure(foreground="red")

    def connect_sftp(self):
        try:
            transport = paramiko.Transport((self.host.get(), self.port.get()))
            transport.connect(username=self.username.get(), password=self.password.get())
            self.sftp = paramiko.SFTPClient.from_transport(transport)
            self.connection_status.set("Connection: Connected")
            self.connection_status_label.configure(foreground="green")
        except SSHException as e:
            self.connection_status.set(f"Connection: Error - {e}")
            self.connection_status_label.configure(foreground="red")

    def download_file(self):
        local_path = self.download_path.get()
        remote_path = os.path.join(self.server_path.get(), self.file_to_download.get())

        def download_thread():
            try:
                remote_filename = remote_path.split("/")[-1]
                local_filename = os.path.join(local_path, remote_filename)
                self.sftp.get(remote_path, local_filename)
                self.download_status.set("Download Status: Completed")
                self.download_status_label.configure(foreground="green")
                try:
                 messagebox.showinfo("Download", "Downloaded")
                except Exception as e:
                 messagebox.showerror("Download Error", f"Error: {e}")
            except Exception as e:
                self.download_status.set(f"Download Status: Error - {e}")
                self.download_status_label.configure(foreground="red")

        download_thread = Thread(target=download_thread)
        download_thread.start()
 
    def browse_download_path(self):
        download_path = filedialog.askdirectory()
        self.download_path.set(download_path)

if __name__ == "__main__":
    root = tk.Tk()
    app = SFTPDownloader(root)
    root.mainloop()
